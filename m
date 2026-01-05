Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC5FCD0425
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E3B83E8E;
	Tue,  6 Jan 2026 00:30:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="leeVXxx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A39D83E21; Tue,  6 Jan 2026 00:30:52 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765AC839F1
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b76b5afdf04so88261566b.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655845; x=1768260645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YOvWyXskgiWVRxzXCq36zFXU84BbX+hLYRSOPpNSTfM=;
 b=leeVXxx+GUGYb8Tb6meneAEKOQ1oj+MqubldbACMm9vmERtQkIj/g/0V/ZvL0Ey1O1
 a7c9ffWEZTV2tF28GWs1SHimudhD8OFXDptHUTp3Xx62KF0S6pQeGREc1h2q55GmK6Qv
 5Mgf3FHxcJCENgnp+eWKyXz1VP/kJ/W3W7AWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655845; x=1768260645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOvWyXskgiWVRxzXCq36zFXU84BbX+hLYRSOPpNSTfM=;
 b=XAeaCNoFBXlRbCeRBfr36TO+xmSpqgml9jzR/rD35EcQ2yKEOG7zgxlEuTuJGisbAP
 OlRnx5hXS9cvApSDycNAeMzL51C11ge0MSI1UAmXFjAOBS1lkccUJTSD+6krNZBQVOyx
 6XxEGb5Sd4qE4PhwNxakJwi73Jno8eLWwt1uEdxFSIkPPvQ9f84HvCwyxjDFqwoVbLMj
 bURUaVlNKN2qxg96Pka2KiNuE9e/4cMeR3NWiz0Reg6AHNvffSbAChcK5EMRxVNXRq31
 w6UZvZ9Ml5d+Ntz9InF373v+/k2Kvv/jGCzSgGxwb9WPL7G3c6K99X6x1bx6eOP/AhgM
 b93Q==
X-Gm-Message-State: AOJu0YyIFflv1L2NZmEe8ppiROs9RlexwNJpjrV77cSgY84zNwN/qReJ
 V6WKk5bX1lOejBk639ZxEi2aS3ca5B8A11y39XmkMuNvrcYV4+D7I83zw9AACjTdmCHoo5li4Nr
 Ir9lypFSy/Bpy/5Fq3IdgzOX6z0e7PDSTycpWAPr7Byt38Ajw6BA=
X-Gm-Gg: AY/fxX6Sb+TAoAGg6mRE8AEvOZtNKM/EkVU1xSHcAiEy1H4/P+dzkkJMwuWR0ySwcJ1
 4s9bhaQMVMKfm4vgvFU19s99gAM7Ek5kEzjHTJ/lW6jBoF+pCGrdM6tiHL3DeDoHAKLsov6StzP
 1tfvVwnkdLrCi4Ky9qwgG0YdAzjEwSXt3FtgqXYptLnm8RIREq+9QOK+F8dwaeXLJhqFal3Hqa/
 YB5w2Z1bg2zTagxmLkTPTdU2zD4XCzrpiumPSRzHrqzO2u9P6JRYKLtfHI7htzEJybCJQ==
X-Google-Smtp-Source: AGHT+IEahPXvCdOrfVSbi2hXhdAQBEqUFiDlHKsllFP+AwsO0urb0+GUiZcIvqu/HmpH1/7bo3P+Sf9lm8KD6aWKD0s=
X-Received: by 2002:a17:907:3e82:b0:b83:7b8c:7c5f with SMTP id
 a640c23a62f3a-b8426a425aemr116737166b.1.1767655844575; Mon, 05 Jan 2026
 15:30:44 -0800 (PST)
MIME-Version: 1.0
References: <OS7PR01MB138347050E7E700D57ECA698EBCBEA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
In-Reply-To: <OS7PR01MB138347050E7E700D57ECA698EBCBEA@OS7PR01MB13834.jpnprd01.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:25 -0700
X-Gm-Features: AQt7F2omGiA25ghu98km4gyd8Ci-iLQAC0w8DssNACyI4PKEWyYB2fcOwbRw0mo
Message-ID: <CAFLszThO9+aN+bAx39a4eQtfm=3CMq0=YjDYJZ3Etuk3NL97+Q@mail.gmail.com>
Subject: Re: [PATCH v2] common: cli_hush: terminate all commands when Ctrl-C
 is pressed
To: Shiji Yang <yangshiji66@outlook.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Shiji,

On Sun, 28 Dec 2025 at 04:04, Shiji Yang <yangshiji66@outlook.com> wrote:
>
> Check Ctrl-C status before executing each command in the pipeline so
> that the Ctrl-C can skip all subsequent commands. in the meantime, we
> need to clear the ctrlc status at the end of a pipeline. This should
> be the default behavior of most shell parsers.
>
> Before the change:
> ```
> => echo start; while true; do echo loop; sleep 1; done; echo int; if true; then echo if; fi; echo stop
> start
> loop
> loop    <-- Input Ctrl-C
> int
> if
> stop
> =>
> ```
> After the change:
> ```
> => echo start; while true; do echo loop; sleep 1; done; echo int; if true; then echo if; fi; echo stop
> start
> loop
> loop    <-- Input Ctrl-C
> ^C
> =>
> ```
>
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
> v1 --> v2:
>  - use puts() instead of printf()
>  - only clear Ctrl-C status when one pipe reaches the end
>
>  common/cli_hush.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/common/cli_hush.c b/common/cli_hush.c
> index 7bd6943d3ed..3f6adc01934 100644
> --- a/common/cli_hush.c
> +++ b/common/cli_hush.c
> @@ -1792,16 +1792,15 @@ static int run_list_real(struct pipe *pi)
>                 }
>         }
>         for (; pi; pi = (flag_restore != 0) ? rpipe : pi->next) {
> -               if (pi->r_mode == RES_WHILE || pi->r_mode == RES_UNTIL ||
> -                       pi->r_mode == RES_FOR) {
>  #ifdef __U_BOOT__
> -                               /* check Ctrl-C */
> -                               ctrlc();
> -                               if ((had_ctrlc())) {
> -                                       return 1;
> -                               }
> +               /* check Ctrl-C */
> +               ctrlc();
> +               if (had_ctrlc())
> +                       return 1;
>  #endif
> -                               flag_restore = 0;
> +               if (pi->r_mode == RES_WHILE || pi->r_mode == RES_UNTIL ||
> +                   pi->r_mode == RES_FOR) {
> +                       flag_restore = 0;
>                                 if (!rpipe) {
>                                         flag_rep = 0;
>                                         rpipe = pi;
> @@ -3207,6 +3206,11 @@ static int parse_stream_outer(struct in_str *inp, int flag)
>                         run_list(ctx.list_head);
>  #else
>                         code = run_list(ctx.list_head);
> +                       /* clear Ctrl-C status when one pipe reaches the end */
> +                       if (had_ctrlc() && !(flag & FLAG_REPARSING)) {
> +                               puts("^C\n");
> +                               clear_ctrlc();
> +                       }
>                         if (code == -2) {       /* exit */
>                                 b_free(&temp);
>                                 code = 0;
> --
> 2.51.0
>

I'm not an expert on this but it seems reasonable. Is there a way we
can test this behaviour?

Regards,
Simon
