Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936B3CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FB9A60740;
	Mon, 19 Oct 2026 09:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sQaZ-YZMLdNT; Mon, 19 Oct 2026 09:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E59560600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792402655;
	b=BPsnl8rwZ3NU19JQ5Zp35ARAWYTbu7D6HYPtMSifsV9gIW7ipRfPsJAviioHCWZMPtms
	 ubojKCpFzLpNI8s6bT5kq2T+8UjYtQK8OyqR+Ogr7D3bdP2XLk7XdaAgOl+bqbIGuVe+q
	 eFp5NVUai3+xlkXG2zCO+OXuiImdvhqd1rN72jb68oYfquBjNiXs0CCGA7BiOmUncV1Qq
	 Fwisv9LwwTw9CGxp7pxXcE6UHGQ64H2GCOd9TC/OnRkV2TVwrJ4Hee0R6uxBfQg/Xj2QK
	 6F3tw6Av8Pq/EdO7LVjCEdY0d9gM5Zkr/oTFOfnNRQIlr5ybIwFkABBvP8ewSJT6OuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792402655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wb1c1EJk9DFTrifg/A+r0IttCiFOqwXE/R10rZRY5ds=;
	b=YVJoFQfvVHghHvDf+Bi8nrS8bZ5rjWIv8tWqNR0Dvy+PGJrp5KfsYePl6UGj3gZnA05Z
	 9/Pzi3M9RKbY72CMPoMO0wcWJOAKpTL22YG9j7LkHQUefwR3XnK3F8se347+M18YcWXGz
	 nors9dTcL2wnTtqw9D8Xc/JVVWUifnlsoYYPTWnr4JXJtMU7UJ12tSytQbViUAU7DpWBb
	 9CfKStJ6+8uZNzfq5kw+SXFOaTicKGsah8OvvcYW8nlPKFyKy+xVy5UiOSGLlbUwYQYwQ
	 V/088mO62qnge1CtrB25CNtv5y/juGvqiNDP7e3v8x+MzzL+fsazjJvU078APV2izAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792402655;
	bh=wb1c1EJk9DFTrifg/A+r0IttCiFOqwXE/R10rZRY5ds=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zaklBrxmfyu4LyB8DelHEeBmPQfPEOdl2R3y9fSpmzg/Az1RPC04UB+HO8ZBF8nWA
	 1cX3luE7upvy3/CjIjm1jcDM9W6xpKconc1Y4zLQ+offblEbUkxmc3BaIrnL3Dksho
	 HU/VjBh2sSXfREIKTSaQODTbrcKjldPPbOuali1JMZkIsx2vvjmvf+yqlgptu0b0Ql
	 gEgjJbLTYo+F2ixSO8EJNw4e2Bu1isjRZGuWGguF57cIj6thwOD770AWT+EKR0xY2m
	 jl49mIYaqxmHJ+QZtLd0kx2qUTKySO6GHdWMJMlCd2BJ/Cy57Jbe7SWKg9Ptfp+ZVZ
	 VirOKcprmb+AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E59560600;
	Mon, 19 Oct 2026 09:37:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B69192A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:37:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A8099406FA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q0u-3sLXrgTF for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 53E2D406C4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792402652;
 b=QNobcLelEJLxvvyvOeXZtjf3oncnkeCD3X4RXurr6TxUACGmd9rbNcSA4sa04mHeTkvU
 q7c4nRnGbsgZhxPJa+YlaSMPNYy8YEEjtGmdOkL1zP+J8+jaOrhglt5GQsgA1Nhxn+GV2
 +zyKlJro0hEPU4Hp9g8LUxWWC3kLrRXaG7NznS8yWDWo3EacXK7i3OVyBmRE97rpFyvlB
 Ws3KZaQnzLI0F1vu79eu8pjIA5hjgQCOIgI6R9wqEjPzKoLvdGV3G4jWC8pZ0VplHv2Lv
 cAWMAUxeJRRZO/cLsmloYT2xcI2Vbm4KKrURegv68SblXMQx3KoTdIkGKXLwp4el5iw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792402652;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=wb1c1EJk9DFTrifg/A+r0IttCiFOqwXE/R10rZRY5ds=;
 b=p9EFaneSGBXqELgrJgDZLg1refWGjMIYOkFL8cYLlTk4yNt9EeVkEPIJB3uol1k86s6z
 VifHt2Do39QXEH3PxdbQU+t7j/THZdKGMSputgUChNkKaS6woDRwmxD8iDCwxQA5ZER9P
 poXc4xjIt5y2KppqaStU0F5pK8S9x5C0MOMdSrzWJBh8Dp0QF6fyYBGkgIjzyTrqVag6E
 EozQQAFCF37B4FDVzKFImCxiHl31CovxUFwKaF6jt4rVOI71H2JfAZTGKUvtLUVNZ0Ze6
 YMLjRzvFaO+ALrDzgkeIX42H3UEiKzBBErhyzJmUWXeQuN4iYXHBVOKQt40ph5bXyKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QIpYhj+J; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=QIpYhj+J
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53E2D406C4
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:37:31 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so13828165e9.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792402650; x=1793007450;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wb1c1EJk9DFTrifg/A+r0IttCiFOqwXE/R10rZRY5ds=;
 b=QIpYhj+JDvKzOAqbBj/q3Ghr3Dl4VFnxT33Nv3vlihL+sCTThZp4W3YZra4Y/4yqbZ
 dIjxDMhLKnhuFSvvCW2Zjx4mmAc+SQ9ldU1wWqiozProbw4pkXa3Dy8Pg3rnDbCniSTR
 5n3fcQpiib0rnuopHl56pYMvdEPTgo3ioeqb0n8SM16Fcigx5F+E/p737WyCaygrQ2HV
 9mkjxEyJt4ZeD1f95naT/pcffznwBw3CzLnpYPFVj9HPqneQF20w6Jl49Vcd0HT5Qdlr
 rg6VBZLf/drF4wwnxEFxdYNQOD2J9JFbZ3dMqTbgpH7cUQc5w/I2t8nNAcuE6+Bjn/S6
 RIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792402650; x=1793007450;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wb1c1EJk9DFTrifg/A+r0IttCiFOqwXE/R10rZRY5ds=;
 b=nSKbvekHRCQQQIqKLdNUOQN+25shDzvOORLt1vi6VzpCzi+TsAHxSJc2pVI5wTD9xT
 /8DqBO6SKGuPQU+W2frgV89AoVwSgM1Zm9OSflcfQb8f1/JKI2fSNWs6zM5f4ZzxNLSN
 cDe8qtpCkrfmQI7EC9vOL67SDB12RbcFG3gfEKzBm0EgjpTJLKh5Hqxn9OZzrYzS3zZW
 FfpxxreKt8se0goTlkDAFhN3C4/ljHB8m4TEVncdKtjcF5quZSy90An+DNR+fy6Jt6wM
 WZ95uMdsJ2RFOxHjG3kGhPW+WPXDKyS5PmV7X7Kxra39lJHC4mSuW0HDDbWUgRlsrAZA
 YrTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0ic/Q/nlVhIDpJP0ibC7AbG7Oudv9JTHx/agZ4fi+4ydc97tBD0iWmz0IooJPq2XCBrjnVnk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJESxLBEb+FaIRftObiWK/MCSOYPbWPrzr+zFFGpyGqMbJm0GGS
 yiwIMQNKEE9qdu/GuREGcCTLJMCHolUloDRK4IxffX67UQ1SBS+yGCScjWJIHyzOdvI=
X-Gm-Gg: AYBFou2ZQUazoVux2IopLqUiUl1waDvjnVVASoIiVV94yZspzkfdS2l1NwTINejw7tV
 0emmvCuGv39hglHN8DMkoWbr/QFcYio6UntOQbvut4Qo+Zn8yhRaNRdA/4d8n19AA4iyFqFM4Gs
 ve8M74+fSUjyOKWiEml58ssDIi0AaXm5jKzOgLOFhVVbznlwUUjR1GS4RZguDEGwy4AQdwdS9F1
 nUMut94VATYtXTdqsCqUJtze8gX6HkGz8DziBo9GrFkWaGLln/HZYCkZPp636F1Xba5f2CYcBIe
 RbmgHMWqIJhZOq1uun8RCKFv8YBUaoZVLnv46Uz2pho5nwpUfnwZeVOXFbwhJSkvcXEvQukMFjU
 mE6GT4jitG5dZQWP/PVbvKeGqoHtbbASiD+rnWyATJjIgrHYy5Zf3s/B/vdXCpxS9MsmInYtWt3
 mOaHqwEo26Mu9UbVQMp78WREcRz+aX2tO1Scct9wZVRHbvLZvXuTYuoOc4yyX+axJXHTE2u+g+L
 4XAXLozJ5C6tClDgTs=
X-Received: by 2002:a05:600c:4443:b0:4a0:89:6727 with SMTP id
 5b1f17b1804b1-4a1d75f9261mr153049365e9.16.1792402649194; 
 Mon, 19 Oct 2026 02:37:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm311273825e9.0.2026.10.19.02.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:37:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, 
 sumit.garg@oss.qualcomm.com, dlechner@baylibre.com, peng.fan@nxp.com, 
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com, 
 bhupesh.linux@gmail.com, n-francis@ti.com, xypron.glpk@gmx.de, 
 s-vadapalli@ti.com, michal.simek@amd.com, jbx6244@gmail.com, 
 marek.vasut+renesas@mailbox.org, Jens Wiklander <jenswi@kernel.org>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: stanleyjhu@google.com, Macpaul.Lin@mediatek.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
References: <20261018205101.2362593-1-jorge.ramirez@oss.qualcomm.com>
Subject: Re: [PATCH v6 0/6] ufs: rpmb: route OP-TEE RPMB secure storage
 over UFS
Message-Id: <179240264831.2276564.2698580298775027190.b4-ty@b4>
Date: Mon, 19 Oct 2026 11:37:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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

Hi,

On Sun, 18 Oct 2026 22:50:50 +0200, Jorge Ramirez-Ortiz wrote:
> OP-TEE secure storage (CFG_RPMB_FS) relies on an RPMB partition, but
> U-Boot's OP-TEE RPMB supplicant only speaks the legacy single-command
> interface, which is bound to eMMC. SoCs that are UFS-only and have no
> eMMC (for example the Qualcomm SA8775P) therefore cannot back OP-TEE
> secure storage from U-Boot today. This series adds that support.
> 
> It introduces the transport-agnostic OP-TEE RPMB "subsystem" interface
> (PROBE_RESET / PROBE_NEXT / FRAMES), where the normal world enumerates
> the RPMB device and reports its kind, size and CID, then carries the
> signed frames. The legacy eMMC supplicant is preserved unchanged, only
> renamed to rpmb_emmc.c, with the new UFS backend added as a separate
> rpmb_ufs.c; the two are mutually exclusive via Kconfig (SUPPORT_UFS_RPMB
> depends on !SUPPORT_EMMC_RPMB) because the OP-TEE supplicant handles a
> single RPMB transport. The subsystem interface is UFS-only for now; eMMC
> can be migrated onto it later as the legacy path is retired.
> 
> [...]

Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs (u-boot-ufs-next)

[1/6] ufs: decode string descriptors as UTF-16 big-endian
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/01c4857ccc5d2a04e8c522335308b08c9027f4b3
[2/6] ufs: surface sense data from ufs_scsi_exec()
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/768aa39691e031acfa53cd7b8bf119e4527cdfb8
[3/6] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/b3cd7ddbbdd57fc4788b7117bf60523cddd90bd8
[4/6] ufs: derive the per-region RPMB CID and size for OP-TEE
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/87094d8062bdda5b5e45a35d9320b40647e12593
[5/6] optee: rename rpmb.c to rpmb_emmc.c
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/20334a6bfdc4dcc061925197cb1ccff4d95ddb2c
[6/6] optee: implement the RPMB subsystem interface for UFS
      https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-ufs/-/commit/3b39df3bc540dbc8d60d54570673b25d6698153a

-- 
Neil

