Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFC606A31F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Q3Xpx7D7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=AKG0ymEQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0657C80D48;
	Sun, 15 Nov 2026 20:35:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jvxih5it2TkB; Sun, 15 Nov 2026 20:35:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5FAB280D5A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794774905;
	b=AEqURyR9Aj/1jNowPorr1veIbvhMcaPostmBjdu08RMmgOyzbyK+5gZumlpiZ6vZMVIR
	 +R9Js4RnKj58kosdoIBXtTg39FZLuwIN1dScEgJ/wrz98783ww/5bTlt9Z8wz1tY6Ckml
	 6+85AN65KHbWMNgnTOaw6Ukh2WRv3i4DwGcoFz8aPNwFspTYlIiNhJ0tRgv320vGKvZiN
	 p/2GOMc7Awdl3SHNDw4ODxVI4gt6XbrX7Ta5pfStN4SiJO4Qtiq4UpAf71JCdJHFtGSIR
	 f8ziylR0rtTOuSLLZgiEMqG1oKMk18oQfC7pd8O0tmJvLIO5t9nbHXFhD70rOK6CXSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794774905;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZsjsWlH1bgTVBbQjYWfBrYI4Xo8IKQ+Izf1UAzzKFEU=;
	b=hiiEyAti6vYSED9cqJMp6NV3+Ssd9vrRbDfCBiaKCV1o0+x3ZybZlzU2QdShtLDzC+2u
	 cXOkRtqKPSeQDGnQUo5NfPf0IM5fmZFU1sNOLDUiWiafiEF76Kk09nkIWWt87CYQC/6S4
	 CfTL1SzYs1YDDOb5yg4EtjVwkBsCwe6naknAtKQgKQh2pTccpH2lCIITTYrG6ygukI3qo
	 gTamltgr6UBgh2m9qHOPj9T1L+3x58JqS2E+kW2W56Hml72bOLdxmDqL2e5fNySMdvejh
	 zN7paBJq3j4m9Ac9xz1hPdV1y4q+hCNG/KeIRODo0APz4SwgADwXDsWU1YohNTWduQA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=none header.from=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=AKG0ymEQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794774905;
	bh=ZsjsWlH1bgTVBbQjYWfBrYI4Xo8IKQ+Izf1UAzzKFEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q3Xpx7D7dIZWEM439XpMgOF6dY0FGaNmIymrADEzxb/++1Q7MktKZKY6xA+WVNLqV
	 5Dc9f1qBE6XSKNkRkrAZ58JaMKjXpH1PAD0KoeUJZxgVBpxt5ux62tKRvQylfFxFWa
	 87lrYt7v7UNBgdAhra+eykW18BaWxu9yY1PgVl+g75tk0OTXSiT9y4KwhbTgpmdFls
	 lJGkCwmNwpJ5rUQzAPebOBRH2cq+ORLnHZUoZCpxF7PIICu6T10R5ovLRe73LN8mhs
	 bRWHEUeUVJH2wHSqp9Zjzx3WATuyJZNcf/XkmwIVR1C7iXF5BV1SL0nR/XuTImfztp
	 NMF2zYIp8lbmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FAB280D5A;
	Sun, 15 Nov 2026 20:35:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DA5070B
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E03BE80D5A
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n03XDMJJNUYk for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 20:35:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C0EAD80D48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.17;
 helo=sender-op-o17.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=AKG0ymEQ
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C0EAD80D48
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 20:35:00 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=AKG0ymEQdg+WVRB7LKxjO14KjlFT7imHO7E3wTh86Hpe5qSgAiesMAjCLiGop+rooIaEUv6OgaPZEygopn/q/pWSegDWHzkg2hhVh9Df8I0YvASpL9I8uvMvxon6sd3S3SbS8lkG/KJv2ZmuhVZUxnNAvbhSQ4W3ADHqElBG4Y8=;
 c=relaxed/relaxed; s=zoho; d=iav.lv; v=1;
 bh=ZsjsWlH1bgTVBbQjYWfBrYI4Xo8IKQ+Izf1UAzzKFEU=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1794774889955653.7320259229729;
 Sun, 15 Nov 2026 21:34:49 +0100 (CET)
Date: Sun, 15 Nov 2026 22:34:48 +0200
From: Igor Velkov <iav@iav.lv>
To: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
Cc: E Shattow <e@freeshell.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH 0/4] cmd: lwip: wget: write the download to a block device
Message-ID: <20261115-re-tom-wget-blk-form@iav.lv>
In-Reply-To: <20261106192113.GA3741582@bill-the-cat>
References: <20261101-b4-wget-blk-r4-v1-0-e27a009e4043@iav.lv>
 <3bb5a9a4-ce05-45c8-9fc4-d4fe99b1b0c1@arm.com>
 <79fdb1d0-c777-43c4-a7ea-98455186e900@freeshell.de>
 <2b5d3f92-666f-4c0b-863e-c681674c611c@arm.com>
 <20261106192113.GA3741582@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom, Jerome,

The series has now been on the list for two weeks. Which form do you
want for the target: wget options (-o, -s, -b) as in v1, or something else?
I'll do v2 with Heinrich's comments in that form.

Igor
