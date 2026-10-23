Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D236B606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0TQhKqhP;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YokEv7hR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 233974090C;
	Fri, 23 Oct 2026 06:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zffyQdaA5xKl; Fri, 23 Oct 2026 06:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6734340903
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792738702;
	b=Q5J9J8hbH/1jAVdu1c3wfL93+KbI4N331rG+3IlQ2Qbhvzq5kMqVhKbrpbfNKVFPjcUK
	 gf3v1+wuKmgEqegYtzi9NIxpCpvd768pZ34gfkx0B4hf9KB4TB1QzCbKKTzPsg6dMvDvN
	 vgzqAOTTOe2ZBKXF6JRm+e/iyy6x/YDeSP5smbfncl7ThiaMx72HnAxuvCx7lKx5BXLMT
	 OUhDECJnXscImXh41J9aHHtrNu4oVwLeuxDqd4RvFGGNhAPcI3YNFzhuRz84QjuEZ2XJV
	 YuD79EoauiuN5lBLxSSmw0WWJM0I8UOeXhGk7SUcM5nQj64iu60J3HuMfXyKVVWNtIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792738702;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=sOuLNCZ6OTlawAxG6cis1tujXjzX1ncWcWYUSuAHb9E=;
	b=qTNtQAt4h5qdqc9xiPNB6xSU4EOa/nF1ZkOuNDZq5GVocX8c4slg2ASYonC3Zbc5hXTi
	 IGBgR9IuK9/nCGVnBbEYSW5/cJx579VII5b73Rtm1nLIud2ZF5yidyuJblZDc0dpN8DjY
	 MoSkF1l1DuOQNaliyeZ3aYZVONTjcTRZtp04J3Jp8BnIJplMX/Wsa8H/D3Y+yY7GlmD79
	 7bDuH6pakeS5RfKMuaFrql1dwHOg5zMB9Ck0i4pe0MeHJdyrQ0JggBavg5NFsYetV/SIu
	 mOfEq/9u68AVGfob7ac7sbNOBUTRg/kxXyuiFXE56PNKu4W27NZ642keea0RPEDaSUw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792738702;
	bh=sOuLNCZ6OTlawAxG6cis1tujXjzX1ncWcWYUSuAHb9E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0TQhKqhP0xgPZxztpYB5ewgqKVsLZJhTDXsSQor0Voch21j5mjHnuuBkoVgPmRe2p
	 BvhKLTPgWj+Mvzi3uH6/UqNxbrGPVuhTjhjdIDXf7Dw534JMnRIPnPuLGClI2Upolf
	 73Qifk9pYblwUTxh7GStch+hq7EX9FCbt/umw7BewEqCEaSmHkR3HGKrZU+jaukkpZ
	 SLb97G1h1ZLpn3kM9LFqMvA2WjU8tUmuaIzkPu+E01uOKq8x+JaiY0AmvRRhRKU6xC
	 1cSUn4TVD+mvqMTAlNysIBgAZRjTmdVCXyCx2PqCGZ9VEpKGFw2nNvFR6GfbjIzrLX
	 ZWlnZ3Ld2CxPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6734340903;
	Fri, 23 Oct 2026 06:58:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 55DFF22D1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3BF9D4008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N0_2aPLZu2rm for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 06:58:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F20554004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792738698;
 b=mOpBqm2hSADQf3QAsjn7mtuP0WefC4EQKKM81Jgc/Do5zyprkTh+750Jng2XM+TTPXA3
 UzS9AFTjhNCTvT9yvR8+oIk0wcl4tFbNXCi5HCQmNAmvl/4ZkYfOj533ylDdgMWxwCvdE
 huXXIuuR6X7uJVXmrZBybmkoqaROr0MM7+PF44zNiSH8LHZkV2nn9p/6A6IXoFNn0F0Xe
 jB9hre0v8GufQzN8nnkQEGS5thniHo4dwLTGPz5vmlPM6oZUir4ccDhxO/Ebs9jE7uAvM
 fRydicUv/6OWn8X4OxS9EBNyBeXiGjUTdTeJ4k4YCJCfPvukMI6bgcGLE0nQ1mlhMuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792738698;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=sOuLNCZ6OTlawAxG6cis1tujXjzX1ncWcWYUSuAHb9E=;
 b=D5xzzUS2kxDju8gDxbqZStfulMLIylV366k2+UvtBBSkQVTuaXroPiuOV9wZurp25NPJ
 pY2PAO3efqzJtB6o8CWwD7dPwTaWLlrvLSo8Euz4LjY5PToRi+EyfXMeut6zgLpNN6piV
 8GTM2M3Oi4WquAumAaN2Bj+dIMrKGiUTgNZVgHlRyADJDDb4Gry8s7bmjydPJLspw1Yva
 SDkj//Zwrh40u63X6E0BUfq3BxREzDxaTSeTg2FJimojrn7Uax+E4nZ2pIPuahE8jSmiY
 hAZOTqk0ykw4lO4tGsXkpX131yVFCVpTa08frnWQP39gI11pgguN6zRYSmExvBkZ4/Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=YokEv7hR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YokEv7hR
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F20554004A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:58:17 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e04773687so136639f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792738695; x=1793343495;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sOuLNCZ6OTlawAxG6cis1tujXjzX1ncWcWYUSuAHb9E=;
 b=YokEv7hRllyIPQlNN1m7NqLJTRxdiVdCz9DNEn1nnGsddzayOPaBPBzsLpcANnbyr4
 B19d69to/2tcsRii54K04bkSWvqqTyMdWRlciBg1QohqHVo3HLfmoui2YKdqx20A8gnX
 QPCwYE6ioHHOiHqGg0wmT7wSgJeHhq1WqIQ+yHISFjeyFpXxQwGi88fqk9boLJp59kjC
 8GQz+LFt3Yn6j0R8JRzQoS0XszmoeHcdPuE7Ba9RDDKi9oz8HrnZX9A8QTIl7nCMrdEC
 JwUZMTpROWvKzgrQNPnc9pyE7Tv3t8LW8Sc8yLOZzoUtYurZMe2ZqgKW6GUAT0ahapG9
 iwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792738695; x=1793343495;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sOuLNCZ6OTlawAxG6cis1tujXjzX1ncWcWYUSuAHb9E=;
 b=KVj6wsQKqIpqXZ2QY38d0nMwKNjGNzfSRWHKgFLqSW4gHOu9iAHwsjdB4Yf6E+T7+m
 JNQ4FZwcuYxpghY2HC0IhnUlCo2+fEvWMNTdLygGOl2XodeumNofeLx4m6JU0+4YGN5d
 cMdl8XVNbccZ6Wzdrbb1wAAQ70hpFmUKoIsV7EAC8nE+sk8tbxVEkDLVf7OOZTf0HtYW
 K8/HJWoEysl1avef8YnkoWkPDghfyzEs+h5Ou9EncwL+KO8056S9sNj281I62Tjqa2bL
 0DH0z1JqLlnoppTMh2VXNklhEpOTw4laS76aQLUMK7x4hoIaSb34/J5syVr+IRUT1+/I
 Bd3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNtsqVg87YI67zagG7gQhkTXsEUKSlHUHtzaoo64ih8AEFL5CO/gM2UPpgeeoTr3ox1BNyxUk=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLNU5/dyv/ql39mJJCu68XvUO1Dy9F3nHUjquV903lj1wrmZxwe
 Vo7D5cJImm4s9Y5ALenEF42oUqRii0NNRfM/sPRoETYxaOMHdB7wDQQn9w4b8Iek79Q=
X-Gm-Gg: AYBFou0hmNiRuPO6IcGBAaU6wWTx4SPm8Ztbup7ksus4Ny9xLovDaoGZ3dL5KN6+XxO
 sEjfs38uMcylMBSfnAkt1Ql4eQN9pn4YYVV3Wh/Y6JST+3TPtc7o/RDmhMWGnL3PO51H4+5hGkv
 SxLrpTblgvYPcADVHPdkJsQy5sxf52AV9idDMisimMu0QAef/46CZiXU3HRgYYcNPcTI54FgMVs
 L5AXlDp2TgnlZMAw3psaa1putUvG0FHGACTp8MV3uxOz+u2A2bvbpE7dxLXG7Y6E6cm8DVb3CH1
 thBuz2jgJR9HzjBtV7Yg68pOdAk3SvEc907xHPl0i71t8/+h0ZXeDUKiyKxpPSuGiSLznm4dv+h
 GIitd2CLPUKxe+nKcAzYRgecjxUXqA2ZdfG2qj+KNRgkCfPFxYDmWrZXkih/IlxcmL/oxwgnsLE
 q9eeHB4kljj9JUX1GeQzwImZvB/izGegcLvDK1UAjxrNPbV6xhpxXAPe5d8hnUJl6xaLUhT5+/2
 QV6CoGW8PKvlh3HPQ0r8Rofqzn0LNracArd3TgR2S9/8+cXW25EbxYWu7Igv1H5FWvruCfhQjOV
 +Q==
X-Received: by 2002:a05:6000:24c6:b0:488:7d08:edbc with SMTP id
 ffacd0b85a97d-48e385b1f9emr1691267f8f.24.1792738695338; 
 Thu, 22 Oct 2026 23:58:15 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38053b8asm2845663f8f.42.2026.10.22.23.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 23:58:14 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 5/5] doc: android/avb2: document the root key
 provisioning and lock state
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Jan Kehren <jan.kehren@emteria.com>
In-Reply-To: <20261022-upstream-avb_lock_unlock_b4-v4-5-f4926ca925e7@oss.qualcomm.com>
References: <20261022-upstream-avb_lock_unlock_b4-v4-0-f4926ca925e7@oss.qualcomm.com>
 <20261022-upstream-avb_lock_unlock_b4-v4-5-f4926ca925e7@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 08:58:11 +0200
Message-Id: <179273869150.1490556.14056769228988954192.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792738693; l=630;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=qoeWBJk9EwbL+HHeF0uNOuHHbMGupA5BYZxZKGKpYyU=;
 b=p/69lN0o2KBxwgelFyG0jHRp1aYVQxBCqLYQLuRlOVkSYT9EUvrhxorZG2S27mqUlcUAbDmxc
 ksygB2rocOgDgzpQQYF7Gt0/Uwqbs0XwOTvmobmWLR4aCMZUAhVXqAl
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 21:04:46 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> Describe the three root key sources (AVB_ROOT_KEY_BUILTIN, _TEE, _BOARD),
> how to derive the SHA-256 digest of the vbmeta signing key with avbtool
> and provision it into the TEE persistent value with "avb write_pvalue_hex",
> the fail-closed behaviour when it is missing, and the device lock state as
> seen from the U-Boot shell and from fastboot (flashing lock/unlock with the
> mandatory userdata erase).
> 
> [...]

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
