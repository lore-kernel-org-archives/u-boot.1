Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E92EC98338
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 16:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3C142403C7;
	Sun, 27 Sep 2026 16:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OWQdk_My9AEe; Sun, 27 Sep 2026 16:42:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7A54440685
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527338;
	b=Ny2mkLKCTHqcrXhGH74LvIsiYVhlmmqkcxnzxLIDYrt+bcH0r/xvX9/FFB0mpc/VOBUh
	 z2ym5/1X2XzA2yw9GRJXHwrg8A5cvZq4k0MUBNvnk7Ab+BsNm6otJVrXWnIG73NWlg3B1
	 N7OS8t57QYF+naJI+IVtHcwuXdrOgm1WQqMpUItmcShm93PXyLwC6NTpr82RcgP31wZLK
	 849dQXcc5ucY4OJAqC7wn46r+oz7pC9ZZOnsaecDHgKAdoyzLRnASqPo9cBMQMN8f5/GA
	 11hHNxygV9DQgxQyO1I+Qiz9FCZNR4grYRoFshmdMBnqeAEDQ4vVvLGvgTzhav4cufg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790527338;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OxEcnqTto6GXdwu3AJ4iDuYyZpOo2f8bGI+Ix2xy5fQ=;
	b=i7kRP5h+m8169QxR52ceAkYdyPfUrkJromdD9ETH1UHegioDGb950qsEqaW/MxXZRERJ
	 Mnb87MjvQYJTf0cf9vXKhuflNzcCN7U3ztAN1B4ntRmpE7wfVw/Aqrv9DoJ/YzCCRzvzg
	 1bXt4SiWGj9Px5zFAcPDbpGH+5ZxCceSTB/lx2n3lERjtrLkTp7sfMBsGfMvKZSNha0yg
	 fotuIyVM5wKTonzAfIDVCHYn6teKea7bR6rKFHT5jJ//tNu4CMmjTB0FDrM3CSnZA/74U
	 S5gqSMDzTWxNPAjn1e9SsIRb2P8oFZm94RBWg64V9DHREAmuEtqbwmzaxL60oLVna5Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kYpgM9Vn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790527338;
	bh=OxEcnqTto6GXdwu3AJ4iDuYyZpOo2f8bGI+Ix2xy5fQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/4O+Ress8LvdZtCfNWVUOpNXHTMEuLgv6EPNTpif3tNDVexJ5RgmfX95xMeG20NQ
	 xi7MqsTo0MyDCpt5AUfhp2NB3JDLlvlEz3EZYhJim717Cuo2GA3+3Me8g4+DPHENd7
	 C6vRZyIugSIqbMtM8jo9h7RMOZxGCiP8ZNbS0ws0z4XVCq1jYUAJwObTpJRMREclS2
	 LgtgXRoSXVdFU9LOhCFuLWP/Crrp7u363Vnm7J91adcrDM3geztS2x2ydCxb4MyUgv
	 PebuGlvVwWowxzlPKfCGffbiqBu+esX4ndeJrqqXhbB3yCB4Z8MfUcOdAMEZmynFBT
	 N4QjARyz5zylw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A54440685;
	Sun, 27 Sep 2026 16:42:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AD263D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28D7F40685
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:42:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HbVf1i5cEeHA for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 16:42:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 12BC94063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527336;
 b=NKDKJd1gJ0LZEtGiIwMoBRk9BaDVMz+8Iupl4jljKJH2mlaM+0mxGSuRL3FgLoE6EGNE
 q1mb4QuIUNFVGEm6ayplQNcm4mT77IvuXOcj5dTgEWX9JzzJ+bEBfFrE3wP+dnkaG5tqE
 LgSALyjwyc5w20+hx9BCoxtZZ1T8koWs2ghFZnx+Ck0QMEsJswoSLKPwh0WW6zLkqSNYE
 EyXX3sCrMyp41k3gsOnaTy44EQL6EN6loR9b8NF+GROg3WMug1FO45LmDmsA9HOo1W9u+
 ciPtBm0CbnG8E1ar83N+wdoX4YsIMOfEhsRDl5ByHOKJlQALC4AenrjCd91Bvdwz19Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790527336;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=OxEcnqTto6GXdwu3AJ4iDuYyZpOo2f8bGI+Ix2xy5fQ=;
 b=Fs8nqmpG/RAur7z7sIQdZ5FAoGv4varlV2VRnRQTuNl8NVabOSV3gC/VH7OltVNza67+
 HhTcN/TMJPieH4lTE7s2aSYO5Z+EFzxqPJq8NYWnLUWxTgOw8NCRDHOBWeq2qj2XwfI3V
 +Bo08LGpJxZmU0/tFljVjSiLb1wjkLSZn6ulv19Z3SAhpB3ZbVtVtZkd2fhvh/S1QhkFH
 eBVmM4ClwkW7kjmkHXz0wPtSeMqBAhYsT1aYVqexjs322WXizVn0hNYcdNqEMiHozx7LK
 PWzed7eB4q5loEP7c+GWez69vOgvmheqnBJ/ZcN5LRZgtvsljg8UP5cK0OVYt2aOImA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kYpgM9Vn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=kYpgM9Vn
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 12BC94063A
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:42:15 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae54so3564613a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790527333; cv=none;
 d=google.com; s=arc-20260327;
 b=P9NhEdUPk3cDPE7BegfBuSF07xZr08Gal5ACN+UrfLhMpOjrMkMLXZNnXqyKY60HT4
 ObmLZct/vSsOenXVYyp6PPHEScnR6r7lyJEK6s2v0HV2k6w0JgJ3I5HfegWMA/3sVkb+
 YnMqANu+qWgmB9SZ1R6NjetUSRDYwBmrrV0JA0obUqyIoBz5DaWtqSa4CXwVEo++3tKS
 gA1nsEHKePSX+MpyF1MvoUUOA5xlti65kTw06qibb4AMGYjGPk3BqHVD+hln5SVy4nyG
 FgwCFAc/ASXP9CvOrvYV2MkcPU3kYtGh+GkM4UqTLSfWe+9fkA4aYLdYqBfkqEyOZwi6
 k9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OxEcnqTto6GXdwu3AJ4iDuYyZpOo2f8bGI+Ix2xy5fQ=;
 fh=qraMckZc7jCpRP8/ViasQITCK3gmkHUxRUeW2N8k9AA=;
 b=lCR/sc0XMH6rQpEsjQNwuwcFYO6cS/5jE/ESN7sE4kHJG43SMM2BZE2WXOYlRxdUrq
 fRYzjTUp4NIbwuUNcAukGHIkDkq1MbzSRLVN0pW4+IPJbTC1xC8ug692JqNuxbAOKaWc
 pU3rVRfFB/d7Eui7nTI9K8BDDRvhU/kMoB6hCfi8fsM1gmq0fIY9X1OmyXViPmstEzDX
 nYaryLcDUSSgl5xdsnUIbBDCZKgSnHCpGpd4iUFPVYo/doaHcprgFQoN7Ry0cwhXY8l3
 bfq+RjFlOUPhjtW6kAGNxlsTzKAbwXX2HQJC2orn1qvw2EJGNTa6z97R+5+HxQPJpuOP
 DJyQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790527333; x=1791132133;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OxEcnqTto6GXdwu3AJ4iDuYyZpOo2f8bGI+Ix2xy5fQ=;
 b=kYpgM9Vn8hfhq2//Ww8vr4oygc7JRzzcCBwnvZtziFAw7cerGzlvKP4GafviAWXC0/
 UxAuk8CxO8PGZ16Kz1xGgwZo4ur7xnH7opZ5ALTPMg6jbO7ez8vuzQJ2hXUWHlItRuGG
 S8ZN9HEb8Hu27oAr0wx/H6OiZfQ3KoD4oIlzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790527333; x=1791132133;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OxEcnqTto6GXdwu3AJ4iDuYyZpOo2f8bGI+Ix2xy5fQ=;
 b=RE7Q26Dgw2kPgxOpbCW3N8A0FHJMEPr0AI6K9xMeNO7cVzz2DERpRjajnYNP5wv5Tl
 LMnnHhr8S6CEsZj43aN2wdtf5e44XyzD+XLyCQrcfYPTBlTIA1J7PHaqQJwLY96+Nxjo
 Q/IE/eVk902BRTMv0TLHjKUnrGu5f8nhg3xErxkb40PbyBo4MBPkZd8I6KSP1AR/Jw2/
 D+pomzc+AXk5yR2CYoHsTfhNZyV62XXNF4Xy4RPd0Ex9NqbpFaK+kevKNkcsbn1xGlES
 n0GXe87HbwnEfUdz5LniEySurZDVsIChvGP5caVSXTKZwxdR6z9Vknofxlg5UJg4nAr5
 bGXg==
X-Gm-Message-State: AFq9FYJe4Oh5Eex//+zfxTjBYNDYw83jB8iDW9mZAdstY1t3WkdkX8am
 jjt73EieRmkklygqV5/bNBJa6KoCk27sfSSZWCyFwaTEBzqNqjyOE4QNfwnBIi4Uoy8TY2p4ThZ
 bGp+/ANyIkvUCRJUxAMY/khqmRE/14MzWMpWSQXUK
X-Gm-Gg: AYBFou2B1fBCdj/1EyEe8NOiDij3bjZnDG//b4rvqtTVCzqYkirFTFtkoYLwjGXQ3L1
 7QLlzAj68R+xvX72p9rIkP0texlFTxB77f7DbvkYLwOYlITRe6kJi/hepY0HafaCQRp2bKDbsP8
 olRJOE6LlLXvPB5srFrQXi4ShIRaA5tcvc6eXaN3oPm+7mIwf8A7Dt+UFqvHtMDtpfzdL0OrWbz
 iEf3NHRkg8sTOgMuGrRnX1hQz10mGCHEkUUWwTlIG5lpm97SfmQfNoxVNJco0cd9TquQDAzX2NS
 VU2/GM07VXUGqDNoA5rGMm/qSFwq+bcbtgrt5pWr0bnt0Slnr/083g==
X-Received: by 2002:a05:6402:1e93:b0:6aa:734a:a093 with SMTP id
 4fb4d7f45d1cf-6aac90c291cmr9024797a12.42.1790527333227; Sun, 27 Sep 2026
 09:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790198142.git.joaofl@gmail.com>
 <91bb73a43793518638d85208944d9f2e37459e31.1790198142.git.joaofl@gmail.com>
In-Reply-To: <91bb73a43793518638d85208944d9f2e37459e31.1790198142.git.joaofl@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 10:42:00 -0600
X-Gm-Features: AclHuK-Nq0vtdHFJVoA03rDoFo-Ist9wDQYkqQNOuQGUWzbjqF1AqLEM6r0PNAE
Message-ID: <CAFLszTi=yh+-zKpk+oaqceLxTm0PPz1mJ5Rb_a5ocJFqGvmrsA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] spi: Introduce initial driver-model support for
 SPI EEPROMs
To: joaofl@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Jo=C3=A3o,

On 2026-09-23T21:40:27, Jo=C3=A3o Loureiro <joaofl@gmail.com> wrote:
> spi: Introduce initial driver-model support for SPI EEPROMs
>
> U-Boot has driver-model support for EEPROMs on several buses - I2C
> through UCLASS_I2C_EEPROM and 1-Wire through UCLASS_W1_EEPROM - but
> nothing for SPI, even though SPI EEPROMs are common and are usually the
> faster part of the two.
>
> These devices typically hold a board's identity: its serial number, a
> unique device ID and the hardware variant. U-Boot needs that early,
> both to decide which device tree and overlays to load for the variant
> it happens to be running on, and to hand the unique IDs to the system
> it is about to boot. Today a board that wants any of this has to
> open-code raw SPI transfers in board code, which is neither reusable
> nor testable.
>
> Introduce a UCLASS_SPI_EEPROM uclass with read/write/size operations,
> analogous to the I2C EEPROM uclass, along with a driver for AT25-style
> parts. The chip geometry - total size, page size and address width - is
> taken from the device tree as described by the atmel,at25 binding in
> dts/upstream/Bindings/eeprom/at25.yaml, which requires those properties,
> [...]
>
> MAINTAINERS                    |   7 ++
>  configs/sandbox_defconfig      |   1 +
>  drivers/misc/Kconfig           |  15 +++
>  drivers/misc/Makefile          |   1 +
>  drivers/misc/spi_eeprom.c      | 267 +++++++++++++++++++++++++++++++++++=
++++++
>  drivers/misc/spi_eeprom_priv.h |  18 +++
>  include/dm/uclass-id.h         |   1 +
>  include/spi_eeprom.h           |  95 +++++++++++++++
>  8 files changed, 405 insertions(+)

> even though SPI EEPROMs are common and are usually the faster part of the=
 two.

Nit: 'the faster of the two'.

> diff --git a/drivers/misc/spi_eeprom.c b/drivers/misc/spi_eeprom.c
> @@ -0,0 +1,267 @@
> +     ret =3D spi_eeprom_read_status(dev, &status);
> +     if (ret) {
> +             log_err("Failed to read status register: %d\n", ret);
> +             return ret;
> +     }
> +
> +     log_debug("status register: 0x%02x\n", status);
> +
> +     return 0;
> +}

Just to check, is this status-register read a deliberate presence
check, or only diagnostic? If diagnostic, a bus glitch or unpopulated
socket will fail probe() and take the whole board down, which seems
strong. If deliberate, please say so in the comment above.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
