Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6DECCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 08:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A40F383F24;
	Tue, 11 Nov 2025 09:58:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zYPIlM5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2583583F3D; Tue, 11 Nov 2025 09:58:25 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF5883EC9
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 09:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63f9beb2730so3258507d50.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 00:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762851501; x=1763456301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RVEEos71B1CZz2Pac3n7f70Mgjd5nR+bB5sgv/o2WHA=;
 b=zYPIlM5Y0j7Iu/898FKh7Ddt2+ZgWr8BsN8mwskOqtc9uZBhjcIOxwObJfDpuBU30g
 FVl5CkFib8buB/Mf3HSEWoMkF/864oOW2nq+zQ6sScLyczhkl5YaFmRyR2aGLNfm27F4
 v9jkuYjPb3q/98x/nrn5/nuPDT7VhRwnODIceCAci+uti6BoOwyoICSk+cuEvtPdLekS
 eWWkXAqsJasPgdn74JDfjPfDG3grb6GFvRlvCMMq7bQucT6/rstvpJQ/HWvVNTPcuDx8
 QRvHxqHaL2cmkFVWuoxYC06xxUVDby03zoMQbYt6Q38pTKCmBDH/hUhy6oSgq7y1fnkB
 mI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762851501; x=1763456301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RVEEos71B1CZz2Pac3n7f70Mgjd5nR+bB5sgv/o2WHA=;
 b=DwtnanFGNK6/i45NvFSEqUpg+Ev1fUI+r7fGpnu/QWI7Zh294mXDBEz63dKHx9LhhW
 O/pCLOvNH34EI9Lfrazsy5zbkiW9u3HuF2dgADJD+xcjvbXrHzu2FXC14uSfGCnLm5NK
 w/qHC5kcRU7qQNregzho5gd2/QcHJsbaRMYnDW+ZPhowpLAjahGxJi9wn2r9aKkSAU6f
 F8XbMqJKpvuY5gspehi2XvM4Syum3vwxrCI38/tBqLsXBArK6X6igL6ef16To1TOLLmC
 JUZyyNBHd+9znsHYPY9VwaFzCXzunw77oQxAcpMWSOGo/PmfkE8++AnQPhBFurksfxF2
 wTbQ==
X-Gm-Message-State: AOJu0Yw3OqK5hbbO8SafqGlsA+UBEy3tu+OERknz07zGwrBlJNZi6kMc
 2QHEcYnfB1Hsth+J31PCkeR9B5NFeOPmtAmA8LJsN+DCUmmbDULDENFSf4qnbZ9VnXKwMyJITf/
 pNFxDTyzGnShgaASKAlDprs1fHOSLkONZiNiidfKKwQ==
X-Gm-Gg: ASbGncu/KdokutyNUN00VANxksFm3OnBY2QYN0CXjjubis0s0ZMtFFre8OOHtjvEf5E
 rNSIERp7FKC1bsHhYhz9Tgt/LHoJngTfhC7Cw6gJYIC6geJ4kFwZ5k8Y4kuTEanyWZZdl1u5scQ
 LXykbhoT7srGIYpUQAgoazJcZ4+iphoyq54HvCpk/T8L8Cnkf9DMT628Vll/BgJA0PRwUsDwdpC
 mFvmLGuT9Uc1Ha0DvK1BfwHWvRrVT9OQHzvh+qbFwkc26A0mSbw2EgZizCQnkNLNJ4IfAUuRhAe
 WGlVaysVPVqRUnK+Lj+tAcVbVCziwCJ/OoWFHODp7znzXbqWvQA=
X-Google-Smtp-Source: AGHT+IFHPtQhChjB3fl2DPYeR0wHw/m4KhpkiPAruHEmc422PoaWCuLSikJEmb0JKnQRxZgJC7fziQVMCAS8rxIWCx8=
X-Received: by 2002:a05:690e:1518:b0:640:e352:4e37 with SMTP id
 956f58d0204a3-640e3525594mr6760430d50.20.1762851501243; Tue, 11 Nov 2025
 00:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20251111054813.1966-1-hs@nabladev.com>
 <20251111054813.1966-6-hs@nabladev.com>
In-Reply-To: <20251111054813.1966-6-hs@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Nov 2025 10:57:44 +0200
X-Gm-Features: AWmQ_bmkaLo2fDpYvJcXc2PFTrIuBEZDDNoi0INCtZt0UHUlV56G9hvr7_tF2uk
Message-ID: <CAC_iWj+W4fTfcg2NhJRnhbBe5pT8C8VzGj7ZxAYmYebAwtShPA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] test: cmd: fix a typo in md5 test
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 11 Nov 2025 at 07:48, Heiko Schocher <hs@nabladev.com> wrote:
>
> In dm_test_cmd_hash_md5 accidentially sha256 hash
> ist used. Use the correct md5 hash instead.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> ---
>
> Changes in v2:
> Added Reviewed-by tag from Heinrich
>
>  test/cmd/hash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/cmd/hash.c b/test/cmd/hash.c
> index 3f7f64d27d3..3a3869831ce 100644
> --- a/test/cmd/hash.c
> +++ b/test/cmd/hash.c
> @@ -38,7 +38,7 @@ static int dm_test_cmd_hash_md5(struct unit_test_state *uts)
>                                           "d41d8cd98f00b204e9800998ecf8427e"));
>
>         if (!CONFIG_IS_ENABLED(HASH_VERIFY)) {
> -               ut_assert(run_command("hash -v sha256 $loadaddr 0 foo", 0));
> +               ut_assert(run_command("hash -v md5 $loadaddr 0 foo", 0));
>                 ut_assertok(ut_check_console_line(
>                                 uts, "hash - compute hash message digest"));
>
> --
> 2.20.1
>
