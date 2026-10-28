Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399CB606A31C
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t5Wo6Y+x;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QXXeUaW+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07A9C80F7B;
	Wed, 28 Oct 2026 13:56:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q-fzGh61Egrx; Wed, 28 Oct 2026 13:55:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A0F480F72
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793195759;
	b=RjXuJrd+tEXyk3v/WK5cfDpnXPSbH3LWrqHsSnr5ki2UUsPvOrt9F2j51lcikdsmbLBh
	 nNUv3/0pkjBhgmwxLyBaU9oQVYXbD8A2AEEVKnl1eHVapFNURDvANIsdHGR9z23xfJcJF
	 a+XXw8fiV7+OPBuxgZhYPylDLIE7vvaZBm/oYpRFAYFw6bYLUbqnWbOsJ+8hrU9kqw0D2
	 NFOYTu+WGuCqYjZuk6ixlOV1u7/6P1MRHadM9zNfBlmZ7Z/YX20oOHG+nZiRpR8QD4Do0
	 QrYs6RjG5KZJPo6qy9z41Pxi32yP/M6DWlj9zv/QzA/h/bmjcRfM3IcTqZmcU4btyCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793195759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BeU0HtpulWaGcrQrGKod9ZEcJ+3YBggSWEEeFXc5Rj0=;
	b=nXiDiSl9Z+zir0X5/+5KqnSle0JHS5p5Q1Bc1f0B4Z6w+SvQ7s90BQcPVWwVJgEpymSf
	 IkxMRna9HHXrvtRa+PwTQfvKwyBwTyBcTExNrWz0L2mu6cJteMQk53ZwF3rglsalJg3b6
	 IMUYZegyBxZcBJWLd4pGinXH2Ay3LVGZzedpFab/4IsQVfht3SwcS6Pv2U1Z1jJkPugUM
	 bHQlazL45fNZy8ItHg2zxg4SjvtopcGp5A53gJFuZOmwloNJpwOBXmg+3nF2uFy0ZlpdZ
	 4/VKj6sSdOa3rS6bnovVSTgluMP4x/GPJhDOanpFB3c/icY68vL2U7gjEECZFluPv8Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793195759;
	bh=BeU0HtpulWaGcrQrGKod9ZEcJ+3YBggSWEEeFXc5Rj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t5Wo6Y+x7jtF7YnR/9rGWAQRtWvCWbFABKDmxZ7ZHH7vrbJ1kbxXSwvThNMzKCxIO
	 RFsrFPrJ1rcR2juUE0Un1MLaCHEtgZrLud+YnnGzdqkvVN2Xz9qZ0u7GtY0gDUvLXu
	 5MihuaDvuKxBeb9gvJekoNlIp4Em9osJEZi/EAD8X2PR1TFUBmXcBgIblAxlG98x/q
	 jS+msi+dGDHt0/iKz8ljwPXwCqlG+z2+6LUyDAEX3YCozJ4cRzsh03DFol586gIGOT
	 TicqRukrhGmncruQ6yNFzYT3QZin2S3AW0Mx4Sp/3DeugOIJq0Dmvudutp1qxNqoms
	 CXe0Zqea8hOWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A0F480F72;
	Wed, 28 Oct 2026 13:55:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CC757529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C914940585
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4VKsoJ7DdIlk for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 13:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B6F1C40560
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793195755;
 b=JZQcUbrEcHXjMxgBRdys0aSIX5uyEeSKH0TRscCdFrmpaSufL90Sm86peyFqBorGAefB
 WO4y0FXMMUp80S68JM1k1T+hNs6zpM8uUtnwDwko834uP2VQDyhiTAFZdV6biTvNuGqsn
 HoudPCoAcZn+ORM24Wx9NLRG8dutLpbbMRQZw23FBWcp1Q9vZr57LW8KfeHuyRSMFCjiv
 unYvSohpvE1RWkhsX3uHt5aEDexU4an/7/7r2LNVXyDWpaXIffUpFCwF1vzarCQkxyLXs
 HgxxrxJuZoFE1NUC75FJXB9pCDUT7ow8wS9PlDB/renGPH1SzzHeG64PLAK6e1czahg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793195755;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=BeU0HtpulWaGcrQrGKod9ZEcJ+3YBggSWEEeFXc5Rj0=;
 b=ahSbR2LL5UWTUE02liXE03yHP6T9AGRlFI3GdO7Eq1CaSLo1SeSBk6k/p1ykf5gs6Z5C
 KdQEV+UrEdUIxZz7p7skeSXhaZjRsczyysK0WgeFe/N6uFofFxlicvB+KYLbaRfC1mrwk
 Vk5HZiR5VX5JFrBG1aLjMTT3YQ+u3PXEkkEkQqsbNgEqB3tVwBWhBbs7qH47Hem++zHJl
 KZov4zBdPKJevUmd+xrkaeTglBifZEF3BKYs0wqivIIK2W6tc0K9P7ZOJFjRUv89I593i
 3Pk0LxvsSLaVPI2e3QQY3jqbv35TFwz5DCmfkEf51SiE3frKFJwSxYo4uBWs6uSxLHg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QXXeUaW+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=QXXeUaW+
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B6F1C40560
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:55:54 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so680459f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793195752; x=1793800552;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BeU0HtpulWaGcrQrGKod9ZEcJ+3YBggSWEEeFXc5Rj0=;
 b=QXXeUaW+V8prHCWsK6h3dZgDC81abUFaVFeT65bCxr3STy2cPiUKH+5VCm86JM56BO
 cNWCwKtYYaE2XaubGDLpLzt1Je35Y2ycuCAeTMXwKugv3s/d1IeEN+pXRuvVUU98aoQh
 FoPd/pLvJpWt02um6XF9ryXdiQu5WsbuB6+QGyU3R0y2608BMbSRipWVpluA0+VvGNRB
 sdLoN1WOeZn1XoLW+bYWX3aOJgucC5XR1+YcH027xrXMOX/Q7JpNcXbHOTCgRB0hBQlN
 LteYNtF4pMwRG7XwM/bmDTohsO8ZZyAXtPsA0eAhxDXXJYuggVL9oSvMVKqsZrCIiK0S
 nvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793195752; x=1793800552;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BeU0HtpulWaGcrQrGKod9ZEcJ+3YBggSWEEeFXc5Rj0=;
 b=VPp5GJ7RNl3rpnec+ks2HoUj/Ci3WSZE+P0m24kUkB6WWJiOI4XhaJK3gymZO6G9Ds
 vV8H8s7HW8rJ0blaI0JOxP3mThmQ6qhpnfbhGqrF8qp/EBvrAOnAR76PYCZdVrVIj4T8
 sK4Qy/dPlXlsnPeWZKNHiCYrmo/C9FnWf3IFwkxF2d1wErTjlXi8p3d8kQtYBiDdjGc8
 GsPmLzzkU/n+QZcrda9K+S+nvzGrTNW0b9FVLftVmI5wBCaqf3hl9th3dcTcbN9+zDAF
 86ktxvTUM6EFgInGVEu6axgYxDZrtdmncP0L/878um4m+CxpF3jwZK33wJjtyASoNjfI
 JNHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBygbuCk9EG/dwgZ6JtMWDspE65F8Bi0dwOXPCOnXvS9SNrKSU5rMh+c0KePSV4aYUSDDbX8sPQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIpnGiCPL0QaycDDcRjCXDGmHCS8W4LRaHBiMxyX8H1SocDi5Bp
 jUCGteo7HTPNIFh5kjfZQeRToG5rzrc3B8rtkoLCUR29uHbPSteDnllVl+OyG/AZvgtOjFrIkUP
 UAATKKcA=
X-Gm-Gg: AYBFou378ooHSUZ6U1zexXh1Oqt0w+eRb1d0YsRmIWxMV+dqIHalQzKR6OHEuwwH6lC
 xZg4xrpl+v7LlmxnyNxriG/AVOWAB+PwnrMT2m2peBs7SDIInrkNXlpFlvq8ycQ9QeYugHNTWij
 5OYMXE4M7qiFjfYB1AfRA91tCX+Wc+T9HcNCKH3K6VGMEUG1BhEwc6C0mJJleZY58G09OZV1FQj
 JPoiCikCrbCKRcOHZEdmfoUvEnLfRO2G0y+pgsbjGdk6ejJik2eoudapHKmkL5pJS+6N5zdU1lY
 yE9FnuuY7/hD2LvvJ8tRwcl62iE1dNj+WQGJoWSoOpdR0cs5cDlVzv2qJvBY5APdHOWK3xfr+HB
 GeRKxZKFVtHfdkcmaWrWgVqLGM7ynY/LivQhoSb/l3TI4Pg377Ni3u/OwiXgn384x0pM3ZtUDgg
 tJnHMm5zX9/c3HeCQqGKUSqeqE7hjfSfyGXILKWnyWZ8kzjF5aryAxrYA7IPb232SpuDxiMg1og
 uIILuXaEJkePa5bRw8izkIrRv+IOn50g6NK5PdoMeGjdmp2hsdqDYssPhUvUWGH8W2QZM1THhZc
 tUI0IoPFD4HxqiYQPFOkx5mVYfggFiVqO5JdjtlpPkU3DRODPio1j3GLyo8XQ9vb+1zypHM=
X-Received: by 2002:a5d:4d42:0:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-48e60203718mr2914221f8f.10.1793195752031; 
 Wed, 28 Oct 2026 06:55:52 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd35c2sm28111848f8f.39.2026.10.28.06.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:55:51 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io, 
 mani@kernel.org, u-boot@lists.u-boot-project.org
In-Reply-To: <20260619073400.387171-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260619073400.387171-1-manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] configs: qcm6490_defconfig: Enable SCSI as the
 Fastboot flash block interface
Message-Id: <179319575058.1318768.11975622367789481298.b4-ty@b4>
Date: Wed, 28 Oct 2026 14:55:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Fri, 19 Jun 2026 09:34:00 +0200, Manivannan Sadhasivam wrote:
> qcom_defconfig uses EMMC as the flash interface for Fasboot, but QCS6490
> RB3Gen2 has no on-board eMMC. So override the config to use UFS as the
> flash medium by selecting 'scsi' interface.
> 
> This enables flashing the images over Fastboot on this board.
> 
> 
> [...]

Applied, thanks!

[1/1] configs: qcm6490_defconfig: Enable SCSI as the Fastboot flash block interface
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/910de77c2b5d

Best regards,
-- 
// Casey (she/they)


