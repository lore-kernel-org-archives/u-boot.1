Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5CACA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 11:17:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9350440653;
	Fri,  2 Oct 2026 11:17:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1iOasTJxyhBe; Fri,  2 Oct 2026 11:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C47A640819
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790939858;
	b=MU4JNf1+6NMla9XGGf2B0aulvuG+J0iJ2Khgr6mHWsEu+StT/2Rx4e3K4twnxcDjT6Hd
	 AeVO0WquiD7RAQjBksWvgoXE43GgP/xBXsFl7Fte1mMoAN3Het6/rL7ZMppX7ZWSo3rse
	 +hnoPlZN1Xe+12YN/rn4LD/Vi36y8dfD16hLCrWeLHi6EnzhpXAmfZRmDdc/0wCuiWtoB
	 Gs242w3k9fKLkoSUbkku3TZ3AODZneFyQW03GSxn2qyfo+3jS9NxcJKCMX3vHxQhM9khi
	 fb3M2mh6Pg90M2Mlz5IiOWpbFY3Yx2IVEDY7rxQljCcrqnYh/R3ojol2uiY7elDCm0g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790939858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Bbi8x+ZBcJZLRfB7QTL28gwtvxqWC7b+JBEB08kFC+A=;
	b=bEB2AmbHsYfrMw7J4h/38Dy07DmoyoS5NHD8FMDmo++UuYquvY4Lo2rB249bGQcjfGTI
	 5ZUfJkpog06LYWTeeivjSOe0g/JodxheqX5/yVD6gYbSODh5o+jNwywwvKS3hd3Qt/RsS
	 Ffpfk7A+qVTIP2ICRbR1eTTJv7ymCvteCgAMZRxVOh+s0N+8aD+Wp2TTzarheAq7azfrJ
	 goLBd/0tk1MdXT/hOgb6BGhTRarXfWwBEIE8tjclxA9tHFrl/uuMRrR82ESFuDqd7QX4L
	 TLIv49hvdPRyZQjAU3bl5E31cWX3ZMDxlWY1tUDgYDaqk17ruBW8vxHoKv1oToBMkug==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790939858;
	bh=Bbi8x+ZBcJZLRfB7QTL28gwtvxqWC7b+JBEB08kFC+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EPCbAGkdFJ239Os3SQQYKK/46auOvoDCJfbw33WzlMRQdRQc173m5EohjgG5HA2jU
	 ZPoUkfU/Bzt6Z1NlROAW35j0lXRhw/UK4oYgUOWPbxgKglAbUB1Kbd2JwKL3f/wiSM
	 ebhvHO5KdjpVW4cKnS373A5/uFG7EBVhctm9yMOCR94VG6019SiDnw/IHThP3FIR0n
	 4N6sTjw3Vb+IpJ+PGbEw2O2BTO6LarxZoXXampCjimdjEpU4k0HxOdcLnjkMcYkbS/
	 N1C0ATtBhrywkSUE5tqHx0/6D3aQX0qK9BWhTH83ogULuJbOefgkF1bz/kBPdLBlJf
	 nM0IROp+NaRJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C47A640819;
	Fri,  2 Oct 2026 11:17:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BF4832F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D33D6069A
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:17:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IcN74QX1fKhl for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 11:17:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9D0E860650
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::24"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790939852;
 b=q/iVLDqJCbbDcsQJn3gf6+inelolHWaW9GLRvY6HtkDaZk6gqwDlgFLEzLkdO1bpiBam
 qCbTXEpsXlR0nyPDeNYLLCWOPV6ALW7XFTyfeJkviyEP1hiexM6QKlr6f9FvAw0SafbdD
 r97Isu0jRRexzkwd59502VpuX+W+AiTDE9NIn2K6oOnrTHmyOVkqKh/bi7/9q7EJVJAcH
 QU1E6uk6ob51C/j4R73v/2NiQvS8ZBZLSaAHN+bMHmxT5QnGi94GrliDIRks2+faS5931
 Ie5odjM3XsQQQs7AwW7dfLpR+F1DqbvHp6FclQ9673euNjVMDjrgyrOB/CidUCtNipA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790939852;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Bbi8x+ZBcJZLRfB7QTL28gwtvxqWC7b+JBEB08kFC+A=;
 b=HNgFyU2gYirxmF5Trean/kodIBfDTgC3XDEWRPVg51eRsNFFdPc/YbPw1pgDcJl/kQ66
 pqpbkZrr3XgogFEsljkCL8L6+NRdxcF0sd3ECWey85DebQQHvxdGaeDE6h0eQ6L1AjcUn
 YBFB5VnVaDoKKCillDLHhxaVitUNNCIPCWurvZ7o/n6Wr0whbIDGWO2+1hxDPQ9FlpmhN
 8ZDyEzhtS0ikhZ7+H4emTtdiHcwkV/szuopwve/uOCh+dAapeOOg2joZ/1ErnvtyTYAJf
 NuxBx+Tkeng1niikFfuYBm8WKFqonhHeJC8t60yeRMgCxcKxo7+/TWnOkJYgxWVRQ+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="N/P9s74t"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::24"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::24; helo=mail-yx2-x24.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=N/P9s74t
Received: from mail-yx2-x24.google.com (mail-yx2-x24.google.com
 [IPv6:2607:f8b0:4864:41::24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D0E860650
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 11:17:32 +0000 (UTC)
Received: by mail-yx2-x24.google.com with SMTP id
 00721157ae682-8ac4967f1c9so30589547b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 04:17:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790939851; cv=none;
 d=google.com; s=arc-20260327;
 b=HJu1PHsVotyZCoQP94mBa4l/1pxXAO+xqEtYQ5jb513Z20+1cajSapBptrd5uEsNle
 7BSmwH/JAN8Fhwj5rWM/RwrMYPA9hVsjm7Mwc4IT48kUIi7T/vBRorrJh9uFs2PKlEPH
 1cAaxuwF7SZjxsnA7PFORTpA1rkWSLHTNWlpE7QdUCOUNTZV22CmthCrGPU0Asfn2sH/
 RFh8tz2c/lyKMnxOofzdMzq7/6sdhxqXQJtIZElAhJ/zyVi/pZaLznQGDB7ueUbYOyyw
 YoBVZbLabCv7rTY7ZNZrp2sUJ5dZc1sTVg8Qxa8rMslULrt12wb82AAdEWjkuEB/vXkH
 3ilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bbi8x+ZBcJZLRfB7QTL28gwtvxqWC7b+JBEB08kFC+A=;
 fh=OBLut4TBLXiCqZ37Ea9TH31U5IYE98Dhuy5dqVawY/I=;
 b=IyzD8rfu6IY4DaFzWr9bLDCjtMNynJCYQEouILEPFGDPuzu5uPuBF4wc3G0+t/YIKE
 zftdqgWqOK9wviBY5owuDLXMylD2ogLp/wQ+lt/Iq5NPZjb8fzEC9/GzjuUOZscn6Zth
 bDdYQJu0YqrQ4OX6jRjGEWR3pUUYjQQK3bgQ+VjO25EJXg9ohmq3Yq7AvQ2ngdEjin4F
 9l/ye2ouqYTp1nqcTqxwvly9Pkosu7wDUHiWKao6FTX46NNK+JywTszmc9lGs6B5Q6Rv
 Ki2cfse1gghFp4ijCBp49dk8b1vSzeZVAz4EHPWx+AGfRMKDK0cHgg979GSkAGB9Q+xg
 nLgw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790939851; x=1791544651;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bbi8x+ZBcJZLRfB7QTL28gwtvxqWC7b+JBEB08kFC+A=;
 b=N/P9s74tz+y+XDHtXFvPoQpkHxkXPaDl/Ey+F41JzESBss8bWK4e7nulkMLK55Cw3i
 jmdAesXlHvgaL5AvazICQS8IaQ0tnU4+U8kVHO+Xxv28cQrdA6TNlOIQiJzmohBqTnEx
 3XRg6xR92BwzA57U8xzq9M1Jdu0csyd6f1I+pAFgMrT98GUnqgPhHrZBrbtnqDuN8bhM
 QvSde3ajDL41pGIWP5dmQWQo0Dd8EebVTYq0NQpFPnnCziWq78rF00bo1n6Sl0X7AJRG
 MkBmknhgbfl832DEQE87n/c2Fn7XmGz3WAyeFgDC3nnfKToPUPNxHsU8ihLTrWhmZG65
 GFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790939851; x=1791544651;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bbi8x+ZBcJZLRfB7QTL28gwtvxqWC7b+JBEB08kFC+A=;
 b=rHBcpbS2JKB9s7P3jzINRuyy+uVZY+EkmdOcHgvSP+vPqmStIXZknvnHW5B37zw1Ov
 LEvlisR7cXgDnSkGCisSe8V6wlSaznYkiGgxCHie+up1/gPH9vlts0JuGAZW+UlFuPQO
 BSYHkKHpz5Mon9ytzBHbbZXkfu3oc8InC9s4N/MWLkLGCtCpQHPg4K+/JBbBRfbVnDQO
 83MpuwOEV5eo2wNJfbwKyrimZNKRBeYd3WJFXTMjkWskwk2CwBCUlli5NWiTt3tS2bqe
 7IqLzMyW71bNczrrI0MVB0LxtEiqRlqTvTu1POrXKOt7jZclH8pyM4sGUwLoiY/sSK3v
 GoUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd6Wh6LKVhuir3Lmuw6BxZhPOvNQK+g2ABfCo7Dp/Q4tgUFNRJzaQK+A7vnyL6Bx8DDol1/qs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJUuEbyPXVGoSLaSjFXUxKtpV6B43BIFXMdGPylRwHV6ILb+H28
 IDGFnQo6sBN8TaLNC037m0JhhecMBKtBLpygXz+YFjUO4mmaBrTRxVRXj8kt70sCWkM24DwQGT9
 9UwV0C449FWC8jZJgTMUVpHSjpCviBOlB5wahF//v4g==
X-Gm-Gg: AYBFou1zEG5ttPufd0LITzofouXfB8U4opkIYxcnO9VFP9H4cVo6E41m0aFTll47AiM
 LBngkYRrI3DM6SrbiJzl13a2pJzYpAAZbGgVgS+lVEQPHXfwmHvVBo0NVjwypXc5QOEXkyECTKw
 O6T/EVWbbs6Tc+cju57KTAe+mkL9P0q8BAHHl2GEs1eNViK8EJTXPLYag1U6OsNNufV5Ug/z7kt
 xWZgYwN84lod6no3CJXV4ZpQexFAfmzcna3p8Ylb1lnUWKiLcpIj1OQkEvCmOtjBHO6gTjfX9AF
 f4+kuOoOTEuP8NO9LN4/4JCtQNR/4eASqVh2lBYuhxIpHCt1iTYHbZHGXckO9kjqHSNflYWqFHM
 97CxTXXP8ob2sq4+H/3qJSaRsTeND4UeqFdzElA+FLQCX+vGySBQdygjEgJETjMi2k2hmNxsRPi
 lgQD5vmj/L7nt1ai6u6ZKqGsr4DMUUcm4/N70uHzSep8RnMgSlu68/6jQeJRz9GH4oGFrFVi8gz
 gCTmxzJ7Y+D43xuOirTxyU+25MNpmRR3ldBCopgjcT3QVLO6UdfbJprEA2telzXKITTUN+pRv6A
 8+IY11rhsIdBOd0ElNfxRKweoZGHoEsVW19v8Zackqi2266p+OgZngWJ4X9JoLW4v9kj9ZHQHJU
 pyUEjLIRjkj8iL7XhvBC52qiu9qDhKdikLMIYuIwWuMXaNYNnL+TZeA==
X-Received: by 2002:a05:690c:f08:b0:865:b26a:8e30 with SMTP id
 00721157ae682-8ae39be12c2mr7859447b3.34.1790939850545; Fri, 02 Oct 2026
 04:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-3-jorge.ramirez@oss.qualcomm.com>
In-Reply-To: <20260918200641.2286077-3-jorge.ramirez@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 2 Oct 2026 14:16:54 +0300
X-Gm-Features: AclHuK-PpLcntQ5NXtCijY2fJ_h5_QOt2_pqY6F5uioGh3vnFrKutLQxz0-q4RQ
Message-ID: <CAC_iWj+MuqZ1LnPCD0SmK5ATgegWZVix3Uj99NwcqkRsWSVoDg@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] ufs: surface sense data from ufs_scsi_exec()
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com, 
 neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com, 
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com, 
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org, 
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com, 
 u-boot@lists.u-boot-project.org
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

Any chance we can get an ACK from UFS maintainers?

Thanks
/Ilias

On Fri, 18 Sept 2026 at 23:06, Jorge Ramirez-Ortiz
<jorge.ramirez@oss.qualcomm.com> wrote:
>
> On a CHECK CONDITION the UFS device returns SCSI sense data inline in the
> RESPONSE UPIU, but ufs_scsi_exec() discarded it and reported every
> failure as a bare -EINVAL, leaving callers unable to tell a transient
> condition such as a power-on UNIT ATTENTION from a hard error.
>
> Preserve the sense data and SCSI status in the scsi_cmd. No caller
> inspects them yet, so behaviour is unchanged.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  drivers/ufs/ufs-uclass.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 21aed9f97bd..3d96a05281c 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1657,6 +1657,22 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
>         ufshcd_cache_flush(req_desc, sizeof(*req_desc));
>  }
>
> +/*
> + * On a CHECK CONDITION the sense data is returned inline in the RESPONSE
> + * UPIU; copy it into the SCSI command so callers can inspect the sense key
> + * (for example to tell a transient UNIT ATTENTION from a hard error).
> + */
> +static void ufs_scsi_copy_sense(struct ufs_hba *hba, struct scsi_cmd *pccb)
> +{
> +       u16 len = be16_to_cpu(hba->ucd_rsp_ptr->sr.sense_data_len);
> +
> +       if (len > RESPONSE_UPIU_SENSE_DATA_LENGTH)
> +               len = RESPONSE_UPIU_SENSE_DATA_LENGTH;
> +
> +       memcpy(pccb->sense_buf, hba->ucd_rsp_ptr->sr.sense_data, len);
> +       pccb->sensedatalen = len;
> +}
> +
>  static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>  {
>         struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> @@ -1664,6 +1680,9 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>         int ocs, result = 0;
>         u8 scsi_status;
>
> +       pccb->status = 0;
> +       pccb->sensedatalen = 0;
> +
>         ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
>         ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
>         prepare_prdt_table(hba, pccb);
> @@ -1683,8 +1702,12 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
>                         result = ufshcd_get_rsp_upiu_result(hba->ucd_rsp_ptr);
>
>                         scsi_status = result & MASK_SCSI_STATUS;
> -                       if (scsi_status)
> +                       if (scsi_status) {
> +                               pccb->status = scsi_status;
> +                               if (scsi_status == S_CHECK_COND)
> +                                       ufs_scsi_copy_sense(hba, pccb);
>                                 return -EINVAL;
> +                       }
>
>                         break;
>                 case UPIU_TRANSACTION_REJECT_UPIU:
> --
> 2.54.0
>
