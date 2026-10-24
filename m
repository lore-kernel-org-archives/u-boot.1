Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C75606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JVjkhRg7;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=n6JidTza
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E9AD408ED;
	Sat, 24 Oct 2026 16:14:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w2qSE3icAKvs; Sat, 24 Oct 2026 16:14:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 976514089E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792858459;
	b=Nbp5xUxzOlg8IevbXFQSKqkafRHUiSv7vxZWjKQoXV5n1tVYx8UFqKWMB7mLEUrcz3te
	 dt+dU53c5taw68x4mjnQIf1yS8xem2Rsjt89OdHhiuNacVdDmmCbMRcw/k84x8BNWSzq4
	 ozjRcOtdc49RVombmVQCrFYkGr9gWJm1wAqOtQqv8huXPsIqPtXsVT2zuh56I77mE6+e0
	 S6uTV2nKm1YDpX0QXh/fotBRE25hNDmGPNsSuefyg9eizdQAKPvOosIKC7ZMyrpUtu4A5
	 NxNHBuYxvRdI2WkQzLPiwT4tTWISWnc5p271TxtmefuwZ71uetMukApZQ1SYwhKKGUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792858459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vfJzEYc1Nu3u9AkkmEfZvqiju3veJVd3WA0S4exM4Lo=;
	b=a3bWt7CDImZ1jq1tAZYyd7keNoBre8KpKnoVl+8pzgcUR+ODlkPN0Y68Z2meS66loE0J
	 L2IBvDrg0pWA0GoXUmip9QwNiSEiSPt3jqdNslM9NRbdYMTjpAfwGRL6KMos+FGkIOs0P
	 hjJaUCq4g9Sdm/hD92Q5P5OvmLOuNhUrjdF/tT2s04wJKaHgPQddl2JKJOgXBT9JZZJhO
	 ug1IrMg0DbEdOWtIhDXlDmaFO4YbchuOzkmhT4nZHsUSaUUEtRStRhsV/rrHfYOY1AR6W
	 xPSWlFUdFftDoeLqRJsGtSlh8rdWerZKg1kbZm+3QbzIhvXXcaqoQ5e24LT9Aofot8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=n6JidTza;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792858459;
	bh=vfJzEYc1Nu3u9AkkmEfZvqiju3veJVd3WA0S4exM4Lo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JVjkhRg7ZTpdaYUYY2eOGH6gw8V+yBpIMRIAsSzz7eKhrskve2sNz7FEH/mZqBA/B
	 zc9UhtSHLNnIkB5mX3DQmrsNKjb6BRj2yysawg/sTcGUBfAWg2wDkRgDTxWdfOiTaA
	 8130Bu8Lt+IQOAjQ/fTE52debilDKakmtL5cim4kUeChyw3e1yvo4F7cenP73gSo/i
	 fXb+R8qKBC5BXEcnW3IAV7lWNd4SqVI84Vs9Daf9ub/N/WefmwYdzTR2lq64LCrYLo
	 cyrhb5Acw4jm3quaGWnSnVP6ekAejxWVl7UQrsa4HPKKqQI9yc6vXZMFu0F6fa7wai
	 778FlNoStWo7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 976514089E;
	Sat, 24 Oct 2026 16:14:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A79E13D9
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D0664089E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1UiA5mfyM1i for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 16:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D29A540873
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792858455;
 b=rE7BSFL53K/pY3Ey47eJk/NFAMPL6HuT/XKzRTwG2OCZ3ax6oY0XhzF0IYZ56NoX8ZSe
 13+N+PKT01/wc1ktYbZLNyPihD3FOAn0FOX+3LnpX41cxgpO2T3Xkl8N3bZUBLagwBtfM
 t4kKv7/lzlzVAtLqANBFoKJgl6p2TnTEsed3rs88Eoq7wVYQzlTFz6DxxtJ+pJIAHgV4K
 gKU2gP4wLn0mzoXP9m4bIyA4zpR5EgxURISjRNOe39UM9iWjhfTRCNpA2vCd67nqdUX0e
 o+GcSZukifoR8vYe8tLMOJVfWRYbdvPz/RreLGQ5ZYXoyYgb7oU08cmKhyDKczRdzKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792858455;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=vfJzEYc1Nu3u9AkkmEfZvqiju3veJVd3WA0S4exM4Lo=;
 b=HntgARBwTM4xv4KMRWZ7XMslt+h4EvrfYQF0g7Hv2Tg1tz4LRQ9+IOz6pZfz5Ocw9hqb
 PBEOs22qmhwYfjbuXICyo88D3Mh8Ik0fbID7yJscmqhZCoSNx4J+PwrrEit54k12qnHBs
 pHjr0o9YqZKIY8FO6cJGDVEwHRJaxRIYCiROVaXBle2rm2PmPAW4EsiR/x9gBHUMVoYdY
 90B2OHasBMKopsr7sXGbLVsGyy85GNiYS//kRC7ybP++jmzSjEZx5FME/s+j7XFZdUDkA
 yElbKVB9rxSooObIKSh/moxGPsTH9P9cNHTjIX3g6mTrMUQ+JD2Y4npYbezddak+TCA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=n6JidTza; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=n6JidTza
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D29A540873
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 16:14:14 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-84e513874f8so1071166a34.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792858453; x=1793463253;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vfJzEYc1Nu3u9AkkmEfZvqiju3veJVd3WA0S4exM4Lo=;
 b=n6JidTzaXx0WgL8wj7IKqLl3ZesyJ+frVV6pP9sK1/qZPTxhrsE0iWANAwYpICoOdC
 u/eJHQQ6p1a64qgJ0bcC7QgdhZ31SMQ7KeX5N/5eEIOXnmOk1GMWanTi/gOaz6Bs0K3O
 g9Q0KzmhRQfKRdYm6Ftma6LhfVNtRVNmbr/tU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792858453; x=1793463253;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vfJzEYc1Nu3u9AkkmEfZvqiju3veJVd3WA0S4exM4Lo=;
 b=TPYY7M0ODUKjcK489o6MxHalttPO/wiwnUOAkgnrfuK+jHeMuyjLwB05p8X6biQe/c
 P90I870M1HrU9tgydzCJeVVgFnrxHrsgtM7g2GYgHdKfQr1u+iPdEvBoL4RX7e9QqSO8
 Y2fDMUYHfruqucyLw8e6rnsLfYCF94peWCwB0mWVa+CFEurVZzMdVp6xva7yKX7MAGcl
 KFqmwhbh2SeGlsLLV3De9EgmXVXMpIP3dnEXpO+WXnkUjh50SjZ4RmusPSZajOsLce8L
 ykKxPJnKb+B1vw4MfuX3lwtKI12Az4HQmFCahtQ64mmzp9lqEE+QkBRrAfcDuPw1b4Me
 lD/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXoZsKAm/oAp53Cs9WLzbrGWHUsfHUn564nM8onrkfyHu7O38Jj0ebD+B6uQYHc+K6cAs0cQg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIxI38/HfxfSNrC+qeB6agoUlGAPfTmjuwEVojo4TEogqISUP09
 nkZUebDBtkVPQbB6x/PCC3K8fKMPXxP/uvYBEw/GQmhTmia0R1LjwzqeSpr7TVWDQQA=
X-Gm-Gg: AYBFou2pGsjskmWOOzP68LHYsBiglxAkbOZrl21GbUQzKc6PA/JrpmQU2fso9aIHoB5
 83YKX3i86m3qGMG83irOx5eS80Zvug+AH5P2QbxpIh+8/jGUP9XyT0HJDRAcaG3Cd1pdWB3INsj
 MEUUeC170LHbsM0JuwVEm6ruOxePF5S1sFYIQOM3VMrO9wq6f4U/YqHsS+vp3t7emR685yqaSoQ
 nh7sRCg1M+l8iqKaEaWMlblyoveVRtFsMDyw3hGoU9fNL3DhuSZstmYBLqF0HYAMlz6DuLwEknr
 cQVHhU4ZSwwgkGGjuWOzHcisq50EspZt/6GR+gtUkuS+sUACO7Oa3nfdQRkggEY/iAVYUFCJlI6
 yRsPw44UwvEdJOv9g9Ia+lzL7S2PlkCVpDeIcl3t7TwDjEzFEJSzon2oM5LdQX7hJ4oMvoatutK
 ED6OImHBB0uAmGHnYQ3vP1WQ8rTfbITyDwM0rivmDO52UG78FeidIvlQ6/wJIsSv9sG1D/T1MGy
 y3D/Xu1mRVt4kEOaIZxB2WbMA54/Vhn6rx1O1/Zqcq6rSV1FL/t9xRtzNIpNuYJsxgTIBpWNssJ
 fa03VCvtTdo3ZyEn5AvY1rfp526V7wwm17CWSwHz6qeAl4g0a6phuQsiRF+8DDfeCZXgomnpQkm
 6hGtq59Y8YmMtyfhoPQ0UbfoM2odlFWIUUWwQ2vZo51EUXTUCvd7jAvMl
X-Received: by 2002:a05:6830:680d:b0:82f:5733:ffbd with SMTP id
 46e09a7af769-850fba2a8a0mr2012590a34.1.1792858453370; 
 Sat, 24 Oct 2026 09:14:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850f8458d8esm2652012a34.1.2026.10.24.09.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 09:14:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagannadh.teki@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.u-boot-project.org, Nia Su <nia.su@sifive.com>
Cc: Viorel Suman <viorel.suman@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ye Li <ye.li@nxp.com>
In-Reply-To: <20260609-sf-validate-uclass-v1-1-263ae3619b75@sifive.com>
References: <20260609-sf-validate-uclass-v1-1-263ae3619b75@sifive.com>
Subject: Re: [PATCH] cmd: sf: fix sf probe using non-flash device as flash
 handle
Message-Id: <179285845182.52652.4512918520758845141.b4-ty@konsulko.com>
Date: Sat, 24 Oct 2026 10:14:11 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 09 Jun 2026 02:35:06 -0700, Nia Su wrote:

> `sf probe` calls spi_flash_probe_bus_cs() which returns whatever device
> matches the given chip select, regardless of its type. On boards where
> a non-flash device (e.g. MMC) shares the SPI bus at cs 0, `sf probe 0`
> would silently use that device as a flash handle, causing undefined
> behavior.
> 
> Check that the returned device belongs to UCLASS_SPI_FLASH before
> dereferencing its uclass private data.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: sf: fix sf probe using non-flash device as flash handle
      commit: a7e43205614890d8674ab07d1b5edf8216ebfbd0
-- 
Tom


