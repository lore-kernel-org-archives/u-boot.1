Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D743606BD0E
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FRCASfEN;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=K6oihUtE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CBE3809BE;
	Fri, 23 Oct 2026 07:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PSaG5zSc0uer; Fri, 23 Oct 2026 07:02:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 944A0809CE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792738948;
	b=WEsEWpfXzPTQffiO41VJylhGfrZD67k1ZlHKo/2CRtVqeZO9zPuvMpzNChLvbIQsODbq
	 CvChN7e9gfnoDENqB9TkmaBCY1S18zwVXFHH8ncV9nHD3nJXOEt3T180HHt4mVe54d0gg
	 EMyXk6EkYDofwAt42fHiiApaDvEkS0pswbt7bFlDW9icKMVhIDBccDw3tpcwQdEug4Bow
	 JtIrENPq9Ki3fgiE4NCDXf4MbW9R5Jr/bg/iPPLITSfL8jGlkzyxQlw6ffBQUBmt9STlW
	 f9E67OGNH89XAx/bNpVghj1nDrQVIBS/Coghftu7oFZhszRdb7I6gPtB4aZK6GAtm/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792738948;
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
	bh=k5lfgTVSP4mpj3d6JNzA5SvKdUcaKBdof1joroKk2go=;
	b=Vp9ojVR1bR5G7KYeFR7FvdH5r3TfnKiMVelMRS8zG6dz3A7JMAC5HiwAqFSJgJCEeQIl
	 IKffh4I0P/JGV4yuBNq47tHOVbyOAvpoSjXwYNLQWPCFupnnx+E9+v189N4jD85/e5oWl
	 ytxyIbC3yeydAkKK3rgd7RQBjKZrC6XjozSvO+CLa7wcNmMfrjOzmZkA0CqcuFaUwzGEN
	 mZSyNX7iRf4Ng+nthDp1yzJ6EDYRo7FTp2Gtfp5GvyFzdKro2+4DBfp7Y+rdhWkoryfUd
	 NGIgTBBueklZnJuAPr97uEvL8462iToLpnKhIST8p33hQPRtjmjatH6eKSdDsjBq3Fg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=K6oihUtE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792738948;
	bh=k5lfgTVSP4mpj3d6JNzA5SvKdUcaKBdof1joroKk2go=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FRCASfEN5Qf2JszgttvAzidczA/oY6uFO+hisQFf4nldjYEafNPSpYdoz4XU8K5fC
	 3w/bZdsx9S1ANHwTHZxIrx863QTR+7Wy507wJotdCJs9oeDch25eviKEY2tIWrG/sY
	 7ietWb7dyZIjs6yiBWMgdmtGtyHNRTK0O2t4WRgT2sVU/WQwgDhC89fC1S0qoZnJ40
	 CTiRZjMkSfHI/DlcBp6Sn4elx0KE2g79l5bf0qfGY3rU7Jn1ib2mrv7yOuUq0DXcX+
	 oCIlbdrD1eoFK6axZGzXMogi01hE6C9Yb4JuBq/sVFurrX9mLDLyKKvwl/s7kOia0f
	 TxJ24dKwbSMpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 944A0809CE;
	Fri, 23 Oct 2026 07:02:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D03A13C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C18A98116F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:02:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-hZFM9rOHQf for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 07:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9AB3180DEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792738946;
 b=R10R1p89bQRKsKGVZ8p2MtnErJpF2V6W2rEsmVeEe6hSibOuiHcRgu3Juj5ygj83UIp7
 hbRWHQSJLSJcccrOUj4OooyTRufFogA1R2jkT4t0KsqR55SpOS6E15YUvVi5Oac6Y+fIf
 2kjMC0eme2w9ILO9HtWiQmAFEBmULuaIsvH2nr5OOEMdZ5LBiAWjoTBMoWbqWb8nT/MAW
 Bea4OVR+WYJgh3eimdXDrZVHP0EvHO8yJ8DUlJuwQWEmG1noAjBg1mL11EaTxHMyHNtwl
 yEQNQgwV4sutPrydmjGSdi9zXRB3U9khfGQrLPXW2p5CAsHbywpj+3sUoUH23l6M4Yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792738946;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=k5lfgTVSP4mpj3d6JNzA5SvKdUcaKBdof1joroKk2go=;
 b=XNazGEMSA9XW26ARv2ms2y3ADqGQijIoKWCz9Pk5ubAsOcgwE34h3BJ6Qhspu6Ox1+1M
 gBe1UBYn/IlXWYGWcSUclSHNnltbgOajacnwOet193kiK8I8OxpJUKvmzmxgX8rtd4eY8
 4t5h6PfTTu9wwyYpVVjpqqOK24HQHyrRoC55TRXVBBIGjosCPr1WSx56grArjDBT8q3BO
 VEiwXZVsR7vIaWX9RrnB0RtNWvLN9pCPzYC6nB4zmCP+jjFB27ViAlu+Xi6ZHqCrJjXJr
 MuXsS44+IbjypxMvow3XyEBN7bU5p0ys8EWz6UFggdnGEENuafUk7EnBc7fA7nYER5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=K6oihUtE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=K6oihUtE
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AB3180DEE
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:02:25 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48dc202a60eso242828f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792738943; x=1793343743;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k5lfgTVSP4mpj3d6JNzA5SvKdUcaKBdof1joroKk2go=;
 b=K6oihUtE41nptQMGavFraIgtd6zLCkKaBEBRgf2KMSAlxNdSdhtPkgoyS5iGQH1wMr
 b7RJ9EhUITrtBT+i0NIuaeSnIzG/GsnTbp9S1ri/LucGrpqNq1sSWhjO0ElPA6AdCzbm
 qLnsvJM0KtibmNvpK1byuMzbHSZqH2G8uYi90OS/aXjBa4AmPTp0WDiz/WOqJhHQGDRK
 Xd5hSo7EuBkER26jT1skGZjYdGdfEqEXlgZJXOXuAVzNBXvRLtfc99znFsTS/e1Gdpun
 cAxekr9SWm3utcN4c5UTxBNGlQ+XpIJjBKOiTvW+55WkEbpJl2tY5nbsnO8srmqHzTxe
 ZS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792738943; x=1793343743;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k5lfgTVSP4mpj3d6JNzA5SvKdUcaKBdof1joroKk2go=;
 b=SHcAvqWU7KcQ3wVc2byR1/q6V3VZ0dayvVT7AI3JFYQCHov/U0J1j8InKkhQZ5uqxG
 4hZLNw9J0IqSdLCdCVatrG2FKrSbW7N3Q38YPLJIlrZVMGhOsoZj+hbxspFKXySGCgq3
 9JCA7ApFbIX61J7MTXwI6WUhViGjhvp33ILgGUU69qcOLZ0KXOF82PPLaaxm/MCJADLe
 PShnMXeWxnEWIsaGpdF5XkquaEdnZhKD0VmMuvWTfF7HpUXuwHsuQRp+7wL7ihkvZrrA
 fQEmMuGuVwx9ahuqNDk7c8yhJrgDTL03vh1SnNKFr1n+soS4BVnmH5fa7wS4axbpXQyM
 d5hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJWcUVy5Y3oS2qkzalF8SD6bvIHheV34uI+RMuTIntk/y4/Mzg03vI/J4nC0e2tCGL2xca69M=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK5v3DEsIuCBWTzBnshApujjZ7k7Hns1+tj35bldfmhshdZeJAn
 GarUAhPsCzqre74dphx7533TjEnJYZ3VeSwzVsOL/ZPemzc6KRVcYFW0tUw43SWImLI=
X-Gm-Gg: AYBFou0XLqaH5AUvFxpU/eVZYG4pOoMJFNT43eftL2pvuV0JN+t7obnY8snK5hgZWg0
 xl2fHCfHoSViqR3ttaLAaEVBqDIAlZ6QIOBtGENJeoDc6OQkJ+1cQKzAEEGV2u/0jfLZPeXucV/
 7uCELVwroyshosfaMx7hR5bg96yHomHP4XuFPyFqw18vcxhC2T6DhlIpGBbBT8QahXQEpPGhPff
 bEfYZmx3rX+UysQXf56adgTBS9D1OVfq+5LWSxp+1NqJzC7oMHBW1z3DhBbzIVb+462NvM+CEW9
 oYIwP5OWldQDZM98b7HURe1Upq7IPs764KVZcbTNosrx8ED3JXG/ttzUY8a9a2Ouftp2mXgQpPa
 /BJTMj3gIGzPOYVFoPQywUMUCBD8SDell6Th2YiFpkpPwHp1d6pgufV6Hri0rHMOTMaONazI+RD
 D7LUwtDwtibkun0Bh8TWajC7IRic5BVTBW5Hhe0jJZ8Ze6Y+6d3qwa0YA5UcxKx+traAzpvf7Xh
 Iabs3EbaQpdoQVMIfedcczqDn+5nXUQwC77ZjrOj5eQ6KxoPA1Pg2vstV8771QPB6AwJZ9Y/PIg
 FA==
X-Received: by 2002:a05:6000:40d9:b0:48c:6a6b:69b2 with SMTP id
 ffacd0b85a97d-48e385a7618mr1657005f8f.27.1792738942933; 
 Fri, 23 Oct 2026 00:02:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3805d708sm3208209f8f.50.2026.10.23.00.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 00:02:22 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] net: fastboot_tcp: act on a command that succeeded,
 not on one that failed
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20261022-upstream-fastboot_tcp_fix_b4-v1-1-df51bb9e972c@oss.qualcomm.com>
References: <20261022-upstream-fastboot_tcp_fix_b4-v1-1-df51bb9e972c@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 09:02:18 +0200
Message-Id: <179273893890.1509995.9533920121725924069.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792738942; l=277;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=SIc1Um6GSpyOJLqE/DBzVsk9tpa6P5YTcK2rRL8glcI=;
 b=HV8gNevLTuOPrNMJH+YCYQWSBCGEEMoRb/DBWvnMdhvcJkj5PBf0FzhBmwNd3mwByDrTNkrvU
 pwvGHgHiftCDz943oh+dNjCNqz+8ZvBR6iUCXWqQ0z8HizModcLTJK/
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 20:19:54 +0200, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> net: fastboot_tcp: act on a command that succeeded, not on one that failed

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
