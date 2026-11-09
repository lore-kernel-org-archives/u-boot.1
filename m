Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13978606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RdaBuzUi;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=s1jpFboj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E39A960A5C;
	Mon,  9 Nov 2026 17:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n72WXyWn84bV; Mon,  9 Nov 2026 17:30:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6A8260A64
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245403;
	b=bt2eHGnMlUlUbWfbdDaG9k/cIZ3um0XMxIV/h+dQeDF8hkVuivxw3mAT1AjnzwXfBvzB
	 BFhy+apNAs1Hy79fX3opvWuJagwi9IGzp68dc+XREq6SA3ZvtwGYDKbOrxkyn1AhCM4lO
	 z3LqP8rjoRauaNF3VHyqvdl2CV53JWz73fKdoScrf1MnbiRAhEoM4/KnHtrHvWuH5FYa7
	 xF49BAGpVJ09DRhBwhvGdEUIrvcjJYBgK9mcsFpynRW9AKRoGo0NuyjdbltKgvULQ5CnK
	 1ZpxtOA1mtqzPZUqcXcj++095J7ny20wysySqdd0Hs0lrssjFTyKp/0+sDRy4rF0sXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=D/F+kfaX/cngs/6ORdrLhPavxdyjAlSf4yii+xgq0Lc=;
	b=Cwjubb4Ae/trSLKKjgUeFShKXSv3QIh/hSX7YaJZKiaj2B1B3JCMoHflTbgoMSzXWhb6
	 7XiRzf3HPlIvCpNr5Ari0qCWT//3MlNYjSO6oSsu208/T756iGauT+7mu2lVxJ2m9VDeS
	 4Wy03SwVDsV1cBx9wIJ4yDK3GeTWhqarMzdma1/hCDzNE3XPuR+52NFIb/iJkkTGuRi60
	 dlQJpA6ymwVlGc6mU337zRhzqRIctMRlNtAQCr+V87i8zD/X14GP1Fnkd3qJ+2UVQdRMN
	 iPeErLbBmmiAtmhaAJ57euqOh50kApduoEPNgjRMgyzDIw0Gc0JNVyKEjoBJ3dXl5tQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=s1jpFboj;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245403;
	bh=D/F+kfaX/cngs/6ORdrLhPavxdyjAlSf4yii+xgq0Lc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RdaBuzUidFlTxIsTRG7f/gmH3hElLoDGUO7bm+V/9DhAQ8QV8iuOPmAMGQEejatw3
	 TEbudobRnv2byoOiTblXUoPmG/S1d8gfzA1sd4ExA3FR3EWr66Z1GMsnE+0cRWj5v6
	 9LYsAlqSMGew/ywt2nHtApIgmQYmu5gn16Zx2UC2YHpWVIMQQV4O94FssXvV+fVAaO
	 bbTdcZR/NpFUnQtpoXtZYy/mN3Lxsmcym2mukwS9D2eheRECYshMcB4uBNMCgpAS2V
	 cwFw6P+gkuTmRo8vwCKyvHkq+h1l0l2SIgcA9EFOh0PZvgVxfFh/OoxGCctK+DEzby
	 vbj07F5ECCt9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6A8260A64;
	Mon,  9 Nov 2026 17:30:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7948628C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B8ED607FC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vCQ_B9umOAV4 for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96747607F0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::a"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::a;
 helo=mail-oo2-x0a.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=s1jpFboj
Received: from mail-oo2-x0a.google.com (mail-oo2-x0a.google.com
 [IPv6:2607:f8b0:4864:31::a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96747607F0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:29:54 +0000 (UTC)
Received: by mail-oo2-x0a.google.com with SMTP id
 46e09a7af769-85ef6c584b0so568057a34.1
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794245393; x=1794850193;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D/F+kfaX/cngs/6ORdrLhPavxdyjAlSf4yii+xgq0Lc=;
 b=s1jpFbojbvLbGFaDtDPNB9CtkPFHLz9B3blhj7si2HNw0xb4cngpl3xyPJmPYGDGd3
 rK+3jtKnS1zxyC5crXewThX1353zqAVvPr4Bsd076Lbhe4lxKCBAtXB9av2D26Y9MUnB
 Y0e2P2PKV1NP75UChG15C/i54zPb7YWLTzvCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245393; x=1794850193;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D/F+kfaX/cngs/6ORdrLhPavxdyjAlSf4yii+xgq0Lc=;
 b=EBx8L9XlNiTpxCEYaUeqTUeyz7vnP7KDVhmYHbfNp8zcDKEWIxE/YXJ+5F4OmM+TvT
 ymrddSy+y0CFE/eL7XZHtkhrVBuVP/+oD9tDo+S2dJxWRNmp5oV03wc3WqhdITkOCk9M
 R9XgvMsbZxwfjPnbBaPDr2i649A9ETfuA33UrfSxt5vptbWJxL+5h8mCC+S+TxSrZ0z1
 u4qddMWtPpiKGIiLgRNHCb5XGymXXelE14yOpr4RGc4o5RW2krhBYIXxa+NG4oh8xXkQ
 0ihrBBYbvzQgSdy5FtSGK9iFotU70FDlOzNyu5UyWHskS9Wh7J3yEEi6+PjHedkNO5qv
 Vkrg==
X-Gm-Message-State: APuU4Z9rPVA6qsN+JpPHaLgmctTI440CHXXWGO/bB6Il5xugUZt1VIDD
 91eDL+cnDUG+eSlMDRKU/qWHATLqBA35+EX1C/FlNVXdNnfHAIP4DF1g5l/wDlU702M5AXg2EPZ
 7d5uao4eEv5luqTY=
X-Gm-Gg: AYBFou2V7zInICrgHieqq33fSAXg0ud1leW82K/P7BDyIP6Wmf/SvhrPpeqiYL/2Xb4
 nL/xuvF01BtWTDqJbl/1T4SQR7dc+xYQDhTfRTeAbowRsK+TzlgaN6TveFs/QhL3ujb+HOJla//
 wHKn6Yino7nSGeVH6SKbXDseW99l1H64tmsE+LZIoVqWCHMypmXJ6K53iAxrtCswHI4cUdMyzQd
 U8sQ508Ep0P0YN9l0OoKoZzfp1pjSC+3gUb6jQSeIG0BopYTqyRIL4dKG/JDkg4sw4CBysvWApa
 oncAXeGYM0C5HoZJYjxRw8jYXvwEBMWqDKRaETZ8jYUNH7zpDqXwCkiL4yPyJAkaq7w4FcghDyE
 1pHr7ErJXmrZ9R+fU88TH1VnmaNLf4Q2gdq9MCw95D33DTyXq6Vs1KSik+aFyxBZN2sBekxFWqV
 8gltXPbZkERftJ2s3cHcapPS2ORn7D64wBcN4SDyzOj/0LPQt3aeK9oG3jHbG3jebJCmrvxdAhR
 UzD49d5X13AHyo0OgYyuh8A2XMwClpYGZGYf6g0ZYr9++ZxePDTv2Fs8yPgU35/0GifLBzrgvfG
 rcp+HBYzPIXQkXDvEMEIhqe6YnBcEci54zeB1reQboakBvW0MlpFZVzKezBx2R4DsYsrW8PXx6m
 trjQqcNUnY49Qnx/tKeZeFdKDSWJP2Z2OyP0exAHDeHsLSPPSA1Abpox+/Bf9D6MlapTO34VnNI
 UdquqBFukMdXivsyJ/OfTSXYbgt+pSxA==
X-Received: by 2002:a05:6830:3115:b0:81e:abb6:7498 with SMTP id
 46e09a7af769-85f5082de7dmr4678590a34.23.1794245393067; 
 Mon, 09 Nov 2026 09:29:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-860db8481d7sm200546a34.15.2026.11.09.09.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:29:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261109131958.2033778-1-stefan.roese@mailbox.org>
References: <20261109131958.2033778-1-stefan.roese@mailbox.org>
Subject: Re: Please pull u-boot-marvell/main
Message-Id: <179424539257.2040456.7187251297467061144.b4-ty@konsulko.com>
Date: Mon, 09 Nov 2026 11:29:52 -0600
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 14:19:11 +0100, Stefan Roese wrote:

> please pull the following marvell changes for the main branch:
> 
> - arm: mvebu: helios4: derive MAC address from SPI NOR unique ID (Igor)
> 
> CI (GitLab world build) is passing:
> https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell/-/pipelines/1929
> 
> Thanks,
> Stefan
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


