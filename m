Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5F4CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3863381305;
	Sat,  3 Oct 2026 13:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gUMPpCt4hYbO; Sat,  3 Oct 2026 13:04:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 590EA81393
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032666;
	b=B4htpZ+tnaSY1+o08o+Gv3/TMI/s7RLU4wwqcjZVghT/HNMPKdviNiZsh5vRMeSfSKQc
	 NJ1iaeBDeJXKDtn2zHBqtU6lkVsMPVDdoCNekI85Vd9Jla1eQRkisAMC5uc9lRiLFcQ1R
	 HIhVyP5BUSTkcmVZaOkkFcPY9xQ9zJUWWvMnwBQXcqZfgrgBvEHqCZSBAhYifNaNn1HLu
	 DTyXd/12uhaW+/cxpMH5RY9u4b15y374EQ7V0HTyiK9M1Gtz1uHhlT3Z+bXmhkb19C8Ry
	 aVrem1i2dqgYgZ0BK6bnhMEzTsXCLVUUuzgm6xraaGf9PuvJfqLJohKQM+4DMuti7IQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791032666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Kblb3PH7/myY9Z8yM2/3C94/90otZbEw9cr2K3QXKl0=;
	b=BVBcPXyelxbB43yxK542xFgIaFCHUQnON5uVkNU7Z0yPeDc8+Q8nnExyRVRUegimsvQ2
	 EQ5lq01idsw+efGZoJHTUfrLi7/nykJD7zHlixqnASl+n/ZaoJ9H392e0yaJGaEja+rnk
	 yjx3CRcH3c+oYqZTa76yS0MQVHPPzdXnJAMfvrHisOmW/vSPUW3XZJMTUEUfCoWvKoJ6U
	 lwmnQVU1AU6KcXbDgBz9FNzjQLrAvOCQKTUdF3MDxOibM1wI38agRgOtmch6msVKNIFTQ
	 uBcLZjDfxTTiJpygjIu/7qTVp4STVS5O/QE5dd7rUD6zReeC3+jRbwFjzx6FZDQkSiQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791032666;
	bh=Kblb3PH7/myY9Z8yM2/3C94/90otZbEw9cr2K3QXKl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNXaVkbsfRPh10VlM6yX85zYmGzHWBOHI21xW03Ao2XJJWkYsr6cxP22W/iancdDM
	 t14mngI4ukFIFoMAS+eljGwCo7vN+Mf4wq4rgOdZPp1qMMFFyhlxKDudL/zIX9DmOh
	 7ihXzBOmxc0QiCpj22bHXDtc5PzXGsby4sSKRiCZti6tnhK5QFOUFMuCzaZmGN4OZN
	 dzCCroeJVoDCD64sO22Q4HT3uiGqKHH95j/ptL3PL+x23bwm6fHqj6g/i7Uprzyx2H
	 8IJ2Tk1BSMd32ZZ+ft49hHmsXb1y+Aaqw1CG7xNmpL5LbeLj9LLJ2qwt4eImEL0f+M
	 tqBKAZu0S+0Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 590EA81393;
	Sat,  3 Oct 2026 13:04:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 70B541A6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D46440063
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NPFl9D-d_ALY for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 62B0640024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::19"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791032664;
 b=aTw5I59+dhycKsd+XqN8i79EG0Ffw/CLmltklV+aWZ8An4GfdCkeFJW5MT7mDqhyDVEr
 EZem67kOtAJb96jscG4CW6NlfMoQQUF8YSUAGvvrwWsg0fWqUN7n21YG5B/pbUskysc4f
 5oLHlFpTlffbHyIkYyQuohdd5Frg2cKzvsKn5p2A+TYDoyAvoHuaZhiJZECv7RLczfFdc
 VuOey5vIp77W/pZjbkPeYI5ae0SuQ1k1NI9VVcogn2cO0AHFSmszGtnIsEths1qvHsWXp
 1I7LSHkqFuJuZB69ZdgsJnOQxDcD6FPIgk/58oHGyhiL7uFlcOWe+aJxAjmg2R6LjAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791032664;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Kblb3PH7/myY9Z8yM2/3C94/90otZbEw9cr2K3QXKl0=;
 b=D5QYHuMV5ctUMSYJagQxBVgqruPpKlTE9ZZbn8/5qZDnfrOO+wXnbIAY+s0gjP7+fNvg
 NdlUYnjjY5d0tvrRHKNvmLyKd0DgV5KlcZ5sJ6ZHY4/Ugquo8wR2XnoNfFrEqQ/R0YvWI
 /MquAHCwUxFYvEjGNuEBLaWec4pDRn81izKZXeckWdcZhHkYNVvkGbd9bmccSASf0rh9Q
 E6AVC3lqOi7ufD9dV1Vaz+XLgOx7H/ThbyHsNkxt86zM3lPIhu7Uy619hUn/BaCnAc3lD
 ky3EFwqvfqfI622+XbP7OItQLmWrES25tiGQyfYGUPcTFeda308qoSTW/Sgj7j8H8WA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=c5kHHIST; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::19"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::19; helo=mail-ed2-x19.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=c5kHHIST
Received: from mail-ed2-x19.google.com (mail-ed2-x19.google.com
 [IPv6:2a00:1450:4864:33::19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62B0640024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:04:24 +0000 (UTC)
Received: by mail-ed2-x19.google.com with SMTP id
 4fb4d7f45d1cf-6afa5b9150eso449507a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791032662; cv=none;
 d=google.com; s=arc-20260327;
 b=NjH+hMe9mFBRzmoPr2lxU3t99wLZbFFhXVRAV9Vw6CvtqAi0NiCqYSIkelePG5Bbed
 KqAIqV0GM+W+CRjKOyVMvN6vR7Ej1f79mHM+0llsW4cFHfjvKYk3mJTSOw8lmj/2otpN
 SPtDZG9jXcVm9ptl7MRlZbbKkLL7OMs4ghvh7bBUUh0gTNOUNXnleTum+ZmlIqNB/jJK
 MoX8flcwAbUV8iCMkA7Yun+GysLuAnO/90+sM3us9aLpUXM/Dmx2CPSdolS3dsZ+X6bv
 kS5NP+GFnbKetX6LApS8GPtU2oU4ZUGZK86J7VNrflyA01PBKUEfZKK6/eMLFmcMCKm6
 npsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Kblb3PH7/myY9Z8yM2/3C94/90otZbEw9cr2K3QXKl0=;
 fh=BEoPNN0ojtgxNz8fjZSoyMObtb+XDDU+qZjnWDTAHBk=;
 b=iitn9e3xNB8j7djmbfGWd3s0RF0mRsvpLA9bMSDGAqmYKxs9ok4OgXB4TgxmQSve0t
 5P5Y+i9PDkOMAJPGsG2gAetHpcU8V03UPdeoQl8DGz7VrUj2R3UQ5hmALHTbwbhk0ZaX
 flK0Q3jUn0t2ZVccJb/JUPThkIpkFgVl5M15RBsMnAdmjzXGREBg7VF3uKu6peXj3e79
 p25JJ5B6pGKqSSbjlXhMU2d3NdAWDSgSv/ZJbuA3xrmNuzwZQmoZs/TUWh5Oi4EK0sbZ
 yXCejNYhDA8MhSvzOdNr3Wqf1RNpq56Rs8wbGL8sgRtwu5vLChGU1bfQQj+jqycBET7V
 n3Lg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791032662; x=1791637462;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Kblb3PH7/myY9Z8yM2/3C94/90otZbEw9cr2K3QXKl0=;
 b=c5kHHISTRngAjsKYjKjQyLkPgBIWF/hnd3dHCaiMcsLtG/f0SoYOgt39NWhaMSui/e
 QH2p/3vdouDK+FgndTSyNSlHa9Gcoph4iGLiKQMGt7k7V+hyd7FxYhShg+f4injxz/jG
 pqLTgnN46ENgtFgiuwQu00t1gvp7hIoSLedy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791032662; x=1791637462;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Kblb3PH7/myY9Z8yM2/3C94/90otZbEw9cr2K3QXKl0=;
 b=S3wkF724UHJ8qNxA5a+kRB60fSO5g+uAhUkhDVFSgmMMLBBNxXSjNIp8V2M20Q5YYS
 g96Qp7vtHJphQpF2UBX7VAsga6iV1TF/TEE4aTAocrvoVWNduaOBFeU+wR1vZrdowuBx
 foj6Qr+SlHrIa51ydfFFKEChxorRIgOwrPgzZ4n5KLinU/hj2hOm2Xf4SQ8QgXoxG2ww
 zqRdlJX3uohiPJyO+TGhBz/43zR4b9vR7oh08XaEPEsJNZ/yJJG9SEYW51M0X+06lWvH
 iUzGX65SwDPPwRtKwM8C6sjCRHLEiMCw6ULd8PKJlKJhl6J/cyScd3mY0k9VY1CJKKcL
 peIA==
X-Gm-Message-State: AFq9FYIuvkB1wXMfBbWTHdf7Zo2WHFXqyfTLJhVHirKyARyWYgRw0t5f
 wcii7zE7/PD9yHyT/tqUYdQxxT2K0BXnuXAT5OpPf5ujikWE37m63lMyTDlv1o6C6MaVRMOyBwM
 W/a1oEyqgINApZ16uNY6GtjwHmDXkKdQOL4KlHj/5
X-Gm-Gg: AYBFou1pjg5uIWfyjNKUSspDC0UMWcajOdVQbNrs2hdAd2NFb1Bg3wrEx8zkHnVwkVI
 dgY9UPTu5Q9ok0UikRjgAd9vWsi2mvqQgT/OBHWX3PVfOIft4Agyu7dR2HWXzQjgmYiMwIhsvT7
 8PJTRiBzBJmuG3igRmGgJVfHEaT6YLuLdpf3RWc6m06k3r9NEjUhCmVRFs5c5AYPl0Zzjn/sUDd
 LxtBZ5wVhENlb5jBN+nF4QPVviiZ0q1+qks/WKg+AR/sC2PW6NAdCBpGKYz3GjDTqzfxVifqUDe
 7jX+8VofzzpW4Ho1Mbai/tPBQbwgkLsrK27UdIKpfK1j+Y+CxcNXTs3I
X-Received: by 2002:a05:6402:4028:b0:6aa:e3f3:c9df with SMTP id
 4fb4d7f45d1cf-6af9e2ea896mr4950161a12.20.1791032662135; Sat, 03 Oct 2026
 06:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
 <20260918-ufs-spl-boot-wlu-v2-8-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-8-8a63e372bb6e@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:04:06 +0100
X-Gm-Features: AclHuK90amYgaWOcgeV51vKLg9l-KJxBXnukkE80yIDy7Vjia1JagYS0h51Tfyo
Message-ID: <CAFLszTj4mymV=buHMAjst6L1NYz23Qn7zCPqOEyFWbXhQarRRA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] ufs: report the logical unit the boot W-LU
 presents
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>, 
 Denis Mukhin <dmukhin@ford.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Alexey,

On 2026-09-18T06:35:41, Alexey Charkov <alchark@flipper.net> wrote:
> ufs: report the logical unit the boot W-LU presents
>
> The boot W-LU carries the medium of whichever boot logical unit bBootLunEn
> selects, and describes none of its own, so the SCSI scan cannot size it.
> Resolve the attribute against each unit descriptor's bBootLunID to say
> which unit that is.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> drivers/ufs/ufs-uclass.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/ufs.h        | 28 ++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+)

> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> @@ -2293,6 +2293,49 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
> +/**
> + * ufs_scsi_wlun_alias - find the logical unit the boot W-LU presents
> + *
> + * The boot W-LU stands in for whichever of the two boot logical units
> + * bBootLunEn selects, and reports no medium of its own. Report that unit so
> + * that its geometry can be borrowed.
> + */

Please can you document the two parameters and the return value here,
including the -ENOENT cases.

> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> @@ -2293,6 +2293,49 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
> +     err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +                                   QUERY_ATTR_IDN_BOOT_LU_EN, 0, 0,
> +                                   &boot_lun_en);
> +     if (err)
> +             return err;

This can return a positive value. When the device rejects the query,
ufshcd_exec_dev_cmd() passes back the result of
ufshcd_check_query_response(), which is the query response code (0xf6
to 0xff, e.g. QUERY_RESULT_NOT_READABLE). The caller in
scsi_detect_dev() only checks for alias < 0, so it takes that code as
a LUN and sends READ CAPACITY to it.

Please can you return a negative errno here, e.g. -EIO when err is positive?

> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> @@ -2293,6 +2293,49 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
> +     for (i = 0; i < UFS_MAX_LUNS; i++) {
> +             err = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, i,
> +                                          UNIT_DESC_PARAM_BOOT_LUN_ID,
> +                                          &boot_lun_id, 1);
> +             if (err)
> +                     continue;

UFS_MAX_LUNS is 0x7f, but a device only has 8 or 32 unit descriptors,
depending on bMaxNumberLU in the geometry descriptor. I suspect every
index past that fails with a query response code. That is not -EINVAL,
so ufshcd_query_descriptor_retry() tries it three times, with a
dev_err() from __ufshcd_query_descriptor() each time and another from
ufshcd_read_desc_param().

So when no unit matches, this likely prints several hundred error
lines before the 'No logical unit carries boot LU' message, and sends
a lot of pointless queries, in SPL as well.

Please can you bound the loop by the number of units the device
supports? Linux reads bMaxNumberLU into max_lu_supported for this.
Stopping at the first failure would be simpler, although it also gives
up on a real error. What do you think?

Just to check, can a unit with bLUEnable == 0 still carry a non-zero
bBootLunID? If so, this could pick a disabled unit, so it may be worth
checking UNIT_DESC_PARAM_LU_ENABLE as well. I am not sure what the
spec says here.

Regards,
Simon
