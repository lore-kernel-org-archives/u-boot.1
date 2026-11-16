Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F74606A338
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wiLakJrp;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x9eAYcb5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 134A0607EB;
	Mon, 16 Nov 2026 18:22:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c8MoTxYoZcNE; Mon, 16 Nov 2026 18:22:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 263EC607B2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794853337;
	b=hqVYl+U0AmDy+E1JsBd+1ypTPXrd07yYYQQkc5+D9jIL838ESmNbtwdkZqJI6Wao8kU3
	 9JRiIcfp9rgmgPSF9vk0d0NyCEt6xbJKx+coTbseIESthkgsFJFlCUtbMWYkrTyIEOPqv
	 EQF5dnPgib5jpKduo1IACHdhmMhBYyLd46u5FG60sC7BG7B4RWPHEws3YQiEbKRD7fKgS
	 KBAEhtS+wcQp7+YkyxGoJzBYdo9sj1uUBtztS3xV0ZqfTJahxvsC01uRwUeRD3hzEFtjh
	 vxUnHXyFz52GRZtfK0KiInxRDAGa/FkTIWExBchNcus2UUdPTXrWXUOd9HlEpgh2hNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794853337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=v8u+MLHZhhlywtjNA2/fYblyo66n1VxHtWIkjfTUbDk=;
	b=N3C24c0rvcsn4FzU/DVrIXODRxN9GkT615Y3L5X3yCzUd0piI6+K4HjB0ZGSOn6LE/X6
	 LMh+mum7bHJ2dPPRsWyoKlbx0CPDruPe/jhqiml9B6UTJ/LAdNRNvpHTsxQIBgzp/I2/a
	 w8agflZTMigiXVllYzR87+dzpl7d6TkbpHrX92bZhlLPm96Ycljy8Ml732wn9+vcdFPfR
	 FyDv6bfR3qumZdAQM8DKe2yuc1Eb/waiAdX4+wp/7ApIczwvgPYNMiasXAr5coN4JNTeh
	 iNQuGcBZrY4eakwrx3OPOiWk6IMm8qNv4aRIxNsi2ZatoXgsmX3nLXwIpW6nxIIpNKg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794853337;
	bh=v8u+MLHZhhlywtjNA2/fYblyo66n1VxHtWIkjfTUbDk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wiLakJrpnpJkHkTY9RJTYosyA6lvf1m4R22VXj6uFoueRG0cnlob3vi0kQ1V9mfS8
	 Ler6Il4EaOHbeQIsWeXiwwiIFUHKIRw2o6hKhsINqYTg4JxBSl2n6uB2/ZjU3o8Jpn
	 l4sHayIF9EODWomCsPAKhhJ2M53dqT15OtoPUFd90msNBV12OHQH6eNjVVRH7nFrE8
	 83GZhlYi3zGoOuwU1Nk8Kh759IHKZQebpjIPgGkHmsBhfQNkef1HJJbQZe4YCPlPmV
	 06dxwmBAims9nSFK/UEAI/97y/F0HlmwgnS67k5x5BSkWMiEL0cofuQ0Rs1B4MT2j2
	 HQjvTVs2iheDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 263EC607B2;
	Mon, 16 Nov 2026 18:22:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D702D176
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BDD9180F23
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UeU5AykMDnWt for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:22:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C905D80F19
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=x9eAYcb5
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C905D80F19
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:22:14 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-37071c0f42aso5579201eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794853333; x=1795458133;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v8u+MLHZhhlywtjNA2/fYblyo66n1VxHtWIkjfTUbDk=;
 b=x9eAYcb5fg1hQWW0ji0m3NX8n/s2i8qw/xpcjgQJHxZKs5QQlfTYfXoEMSKDj80H2J
 8V080Be/JsIbrVgzNMbiaolIWo5RzeMA43Kid507cxiDQjShr0BR4IlG0CHfYkkVwcDH
 or3J+t/ve2cwE86KVa3gQWR4iHc2hBg2i7ain4i11/jFaL4dFjovgy2CJvzywvNTHgp2
 jGgL5R98o/5gVUfApiqAC5khCZQqQ5EGcgp6uE98JW6/A2NJpTgfSiswboh9VoV5tHX0
 XlFN18IVg2TsFqJOkiZLzztYaYNKnOTzKPwMw9uwuh3EIu1A4T0Nl2EgLufW0ygvBnG1
 uV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794853333; x=1795458133;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v8u+MLHZhhlywtjNA2/fYblyo66n1VxHtWIkjfTUbDk=;
 b=haUoVpBQLtMMY+ofrSNnjNvkEx+baHeI2g3Y0Uz948CS/u00uq+cP+lcag0V3DznBA
 b8Ml3WS1PWSiYVRwU060qaPqIIiBRudqD6IgHWYZO5Lvq9HBjD07yKxwwaEcPXgh92uH
 Kj/wLGZAzwZR+FqoR+ekyXSp55LQFM3kuK3JqugorwbMXLIeWS9ZqmoQpIlAjHkqzu70
 Eco3eSgLkdfQ20sHVbvloGT+mZjtgyLS/yaCnUC1xnZfYzYL9HCFvnqdJCN3QKs9TNE0
 G/f4KzLG42Ov9fQmSsXG5Klp3GEWJCyUrpUD8gfln22vWjEXZvxaqzg6vTdItdjwHMHf
 rDjA==
X-Gm-Message-State: APuU4Z8o/5jjMljK1JtBSBpeqXdzmixiYt9zBsAwc1wi/bUFVClKFvCb
 wI5u9oypDbIe+LXwoehdOp3olt0+shFsOczemQ1MD7Q6KakSBhOv34g5xOQPIzVXZ9OBHfrJOBT
 6YYCG2B2OtmRRHSiJzzN1xztnVtmr5Fg=
X-Gm-Gg: AZFdTZeRYVa5jfX1eYuYfnxDfGme44MuhjXeC+y1n3v4deMacBavDEQGwCtmK4oryQa
 k0YxQlSTYQMguvh/97gGf7uFS5PkVKG+ud29w4MhlRCisL4Gvu1uSra52Kp50q6xsT6+8qVJ0lD
 03rf0LlQSM7bh/BBxeEyhCZOL96pJzrFhlKrTHqB796cZ5Kpkmme4v3u0GYee4UZp4ZlM6Kbvm3
 qXfvbJAosB6poKhRPSoEg3L7jj4rbg0V7hJgS1s7rw6oMHQ7NSTWkbWNL1Yp76kHGf2aEqSBrf+
 +3/wvOs+BfMEMYG8IytWzuIfJI0yKDmAOWSss3EnLy6N1XsJvuxFIAq4eNfApr9uSOGrYPZ0GuQ
 8pVgc5kJvlqifM0yriFMvshlHaAxR1e2w8xhwTjKq/tmAKKiQaX8Cgi+LXP9moy0E0LPg8d3XUE
 isVlk16lXOU+uDRAMPsyqnhIICABABnTJGJKFRqW4T0iKJR82OrTI=
X-Received: by 2002:a05:7300:f694:b0:376:203e:7d7b with SMTP id
 5a478bee46e88-3796337436amr17022137eec.2.1794853333570; Mon, 16 Nov 2026
 10:22:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20261116174340.3488324-1-marek.vasut+renesas@mailbox.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 16 Nov 2026 20:22:02 +0200
X-Gm-Features: Aa3M54rwfd358pt5YBDu-HaVm03mnhb8JPMrElY6WA7dBoJKA1gm_YZoeV3jh84
Message-ID: <CAPVz0n2ftpVfRNmudF7A_DbOF7W=Ay=ZOTuKVBLnbr4MSALW0w@mail.gmail.com>
Subject: Re: [PATCH] sysreset: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>,
 Daniel Palmer <daniel@thingy.jp>, David Lechner <dlechner@baylibre.com>, 
 Eugen Hristev <ehristev@kernel.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Hiago De Franco <hfranco@baylibre.com>, Julien Stephan <jstephan@baylibre.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Leo Liang <leo.liang@sifive.com>, 
 Mario Six <mario.six@gdsys.cc>, Max Filippov <jcmvbkbc@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Thierry Reding <treding@nvidia.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tim Ouyang <tim609@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>, Zhuxu Ran <zhuxu_ran@zohomail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 16 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:4=
3 Marek Vasut <marek.vasut+renesas@mailbox.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bradley Morgan <bradley.morgan@linux.dev>
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Eugen Hristev <ehristev@kernel.org>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Hiago De Franco <hfranco@baylibre.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Leo Liang <leo.liang@sifive.com>
> Cc: Mario Six <mario.six@gdsys.cc>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: Tim Ouyang <tim609@andestech.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  drivers/sysreset/poweroff_gpio.c           | 2 +-
>  drivers/sysreset/sysreset-ti-sci.c         | 2 +-
>  drivers/sysreset/sysreset_ast.c            | 2 +-
>  drivers/sysreset/sysreset_at91.c           | 2 +-
>  drivers/sysreset/sysreset_cv1800b.c        | 2 +-
>  drivers/sysreset/sysreset_gpio.c           | 2 +-
>  drivers/sysreset/sysreset_max77663.c       | 2 +-
>  drivers/sysreset/sysreset_max8907.c        | 2 +-
>  drivers/sysreset/sysreset_microblaze.c     | 2 +-
>  drivers/sysreset/sysreset_mpc83xx.c        | 2 +-
>  drivers/sysreset/sysreset_octeon.c         | 2 +-
>  drivers/sysreset/sysreset_palmas.c         | 2 +-
>  drivers/sysreset/sysreset_psci.c           | 2 +-
>  drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
>  drivers/sysreset/sysreset_raa215300.c      | 2 +-
>  drivers/sysreset/sysreset_resetctl.c       | 2 +-
>  drivers/sysreset/sysreset_sandbox.c        | 4 ++--
>  drivers/sysreset/sysreset_sbi.c            | 2 +-
>  drivers/sysreset/sysreset_socfpga.c        | 2 +-
>  drivers/sysreset/sysreset_socfpga_soc64.c  | 2 +-
>  drivers/sysreset/sysreset_sti.c            | 2 +-
>  drivers/sysreset/sysreset_syscon.c         | 2 +-
>  drivers/sysreset/sysreset_tegra.c          | 2 +-
>  drivers/sysreset/sysreset_tps65910.c       | 2 +-
>  drivers/sysreset/sysreset_tps80031.c       | 2 +-
>  drivers/sysreset/sysreset_x86.c            | 2 +-
>  drivers/sysreset/sysreset_xtfpga.c         | 2 +-
>  27 files changed, 28 insertions(+), 28 deletions(-)
>
...
>
> diff --git a/drivers/sysreset/sysreset_max77663.c b/drivers/sysreset/sysr=
eset_max77663.c
> index 8febcf8de6c..a4ed763f743 100644
> --- a/drivers/sysreset/sysreset_max77663.c
> +++ b/drivers/sysreset/sysreset_max77663.c
> @@ -41,7 +41,7 @@ static int max77663_sysreset_request(struct udevice *de=
v,
>         return -EINPROGRESS;
>  }
>
> -static struct sysreset_ops max77663_sysreset =3D {
> +static const struct sysreset_ops max77663_sysreset =3D {
>         .request =3D max77663_sysreset_request,
>  };
>
> diff --git a/drivers/sysreset/sysreset_max8907.c b/drivers/sysreset/sysre=
set_max8907.c
> index 6f62af9bffe..ac268dc5e61 100644
> --- a/drivers/sysreset/sysreset_max8907.c
> +++ b/drivers/sysreset/sysreset_max8907.c
> @@ -26,7 +26,7 @@ static int max8907_sysreset_request(struct udevice *dev=
, enum sysreset_t type)
>         return -EINPROGRESS;
>  }
>
> -static struct sysreset_ops max8907_sysreset =3D {
> +static const struct sysreset_ops max8907_sysreset =3D {
>         .request =3D max8907_sysreset_request,
>  };
>
...
>
> diff --git a/drivers/sysreset/sysreset_palmas.c b/drivers/sysreset/sysres=
et_palmas.c
> index 9e3aa403488..e80c78ca482 100644
> --- a/drivers/sysreset/sysreset_palmas.c
> +++ b/drivers/sysreset/sysreset_palmas.c
> @@ -41,7 +41,7 @@ static int palmas_sysreset_request(struct udevice *dev,
>         return -EINPROGRESS;
>  }
>
> -static struct sysreset_ops palmas_sysreset =3D {
> +static const struct sysreset_ops palmas_sysreset =3D {
>         .request =3D palmas_sysreset_request,
>  };
>
...
>
> diff --git a/drivers/sysreset/sysreset_tegra.c b/drivers/sysreset/sysrese=
t_tegra.c
> index 10bcd3a1873..d498aaea73a 100644
> --- a/drivers/sysreset/sysreset_tegra.c
> +++ b/drivers/sysreset/sysreset_tegra.c
> @@ -29,7 +29,7 @@ static int tegra_sysreset_request(struct udevice *dev,
>         return -EINPROGRESS;
>  }
>
> -static struct sysreset_ops tegra_sysreset =3D {
> +static const struct sysreset_ops tegra_sysreset =3D {
>         .request =3D tegra_sysreset_request,
>  };
>
> diff --git a/drivers/sysreset/sysreset_tps65910.c b/drivers/sysreset/sysr=
eset_tps65910.c
> index 98da56661c0..957c73f04f2 100644
> --- a/drivers/sysreset/sysreset_tps65910.c
> +++ b/drivers/sysreset/sysreset_tps65910.c
> @@ -43,7 +43,7 @@ static int tps65910_sysreset_request(struct udevice *de=
v,
>         return -EINPROGRESS;
>  }
>
> -static struct sysreset_ops tps65910_sysreset =3D {
> +static const struct sysreset_ops tps65910_sysreset =3D {
>         .request =3D tps65910_sysreset_request,
>  };
>
> diff --git a/drivers/sysreset/sysreset_tps80031.c b/drivers/sysreset/sysr=
eset_tps80031.c
> index 50024fe4e79..1a0dc2adb16 100644
> --- a/drivers/sysreset/sysreset_tps80031.c
> +++ b/drivers/sysreset/sysreset_tps80031.c
> @@ -29,7 +29,7 @@ static int tps80031_sysreset_request(struct udevice *de=
v,
>         return -EINPROGRESS;
>  }
>
> -static struct sysreset_ops tps80031_sysreset =3D {
> +static const struct sysreset_ops tps80031_sysreset =3D {
>         .request =3D tps80031_sysreset_request,
>  };
>

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com> # Tegra, Maxim and TI PMICs
