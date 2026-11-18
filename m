Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37A606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DcQR7dfU;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=N8BLlCJc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0690B40761;
	Wed, 18 Nov 2026 21:23:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zAvHiCPjpnAO; Wed, 18 Nov 2026 21:23:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 522A240799
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795037027;
	b=lhhJbzTJDqs0WMKnEDTX4IZScOGR+KVS/RNuhZ+11VM6TlQOHuYfjXdC0y0p2ydsrai8
	 eI7Djx4ZmMnXJLhY6YYF8QQutAC4aR7WZZo16OPYHW45oQ9Ik7kqHUpHscfygRUVLRPRm
	 mvmZCBBgpcpLxThjH+05pfcp6EdpREskCfpGCiU33NCNyJ43+97I2z74mRIuBXxsyP4Tv
	 4r4jrmuY/wBYg7p3Pr2MEA5j5IPBhrI3z0K8eA6tKfGSpDb4PKPnubK1jP8laV0r2fa2S
	 5W90mGNiRLOScRcmYOYV7jeq9dqlZdkYoOydNAaA6yVNNxByj2c2jXcOVyCbymO4VuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795037027;
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
	bh=x7fT0dITbn8yKbD2sY+/thk87em/saik6bDNlqe0tBQ=;
	b=RFjRN0JDI7qUAheWhWkl9hDKmSFwkzm1E5CwFF9W5IqkPPMp+WkX109yAAqKv92TTGO+
	 v9B8yOc418xa6xgGxymwsV8RDP3BvFSY1TeGdSWeZSKXFSt1nF0coXBkpZg66S1tgQ7H9
	 At/ovvvM/xqZb9h8Y2iaKvLxqnG3vFrLSxtnmaCv2HOyCUeCtCHXvPOJA2qGxkCx7WyZr
	 4iTs0upvkeMgJdhKMd6OFnHkLdlrCWPyze+OgZ4g3woKorzVslbCF8smJjRERVqBU9aNj
	 FawUVsimVOoUaH7j2G05hegeK7F3nS445+UGOO7IPHMlFq85YW6sMUMHNNYFsvLroAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795037027;
	bh=x7fT0dITbn8yKbD2sY+/thk87em/saik6bDNlqe0tBQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DcQR7dfUmreM8gEGkRzVC83fr1y5w7L+gxTpBlWBSHaL86oeY+9je8/8a7yP8sYXG
	 pkhd2ZflixLshF6v1VucAmE3ztbtfK8TMLxBlFfQ9DnN1PjbUiPaIeqiAM7tZoIE56
	 DTymV9oy8RxmFUwDY0I2eXthBfey9dgy9dbAVfmj6/mVoPSt7ohmAjNwUeaTmi3nhS
	 QVTsPZHYJAVp7HwKGDcTsYrXbwOMghVNW+mXX2Ugy3NaLky5NcKuPHjhzKlnKJL53g
	 7l5Me1cS8C8Nr/NbV+62VguV1ROkC1e9GbyDPEJm2JHAt5CzJYrqD5zQWJkPmB1A+T
	 wS4PLeSx3A8ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 522A240799;
	Wed, 18 Nov 2026 21:23:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB6D59F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AD75380BF5
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NpmSF6WJuZac for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:23:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A174880899
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::434"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=N8BLlCJc
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A174880899
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:23:38 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso207815f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795037016; x=1795641816;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x7fT0dITbn8yKbD2sY+/thk87em/saik6bDNlqe0tBQ=;
 b=N8BLlCJcEFjy9XTRDyAiRMlih4ZIsDsIKcqkqSvH+N9nyCcmQnKnu9BvnGfQx+EfuY
 D/oWqTqtvo/sHDnhFpM1RtbyzE0pijhIxriNfizIzFKnWLOh4jRq/oF0yvqeA1ePXRTT
 uZQvoyDSQyg/IWCT3PTTsj4aVMUQV/CWYyODqOTvg0/xLdj/Se2KFlq2eLARcV6YDl11
 1aS1JVicdd7ghFQf58wQWcf1SGrCCyeFpeBngfwDO07h4irhw0rLoeDwcTT+1RkSzBiq
 gRQ7czBLQ250i2wKuSsL5TLHvIVXYD5RirlwfUoc7UW1PdxCX1qllf6UamXUxdji8YHi
 bE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795037016; x=1795641816;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x7fT0dITbn8yKbD2sY+/thk87em/saik6bDNlqe0tBQ=;
 b=QvVgJ9D+5e0FwHKKL2KTw4Oo50O9P1OmCtf9djRT850BDid+8iig+D6BLeYzuRXVWr
 WIL9BLl1jP271mQ6w+5u0KScBmT2ytERrSUvRgcCg+faIUvBoPa4r87I1nG1yzRIS9rV
 cvNGLNEzGEj35X31R6Mtwu9kAfEQ3wleGiailGXJxcakKC6hmOCQA28w8wTyeneCMTdP
 lcFMyzRPmgbOg7h1x4Ahgkv0POitGlAAJ+j2DAWxFa+C+HBgjCnlkj6UymcLN4ldfjVV
 gBf9CxI3IHW2MY+jpdFGgJRAGrM4FqOEMbY8e5ERfNiZxyo4fPrSm5hU2LcFAfIcOUfd
 vtWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFjlKwGNyL08U61zNRYWOT0M9kqHlLtKtt4lTNF41GekOMgVmpAjZiNlU+hLX6L6nuqzcUyu2E=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+AOMKcWQYctiFawW1aV8vzmisPO/XKoKmALEWBs6YDTQJX1Fu8
 NndkT5ibDjdb+ZRk7p79jvUQ7UECIyF9rH1GZAv5urKYWDmKf6Rh2ni91aQImPkbsjw=
X-Gm-Gg: AZFdTZfXt1lBgx43LfH8WKUqQAB3fQo/v0Q7JVc82uBTyYmXUDWRijHsAC4h0oqsIG4
 dE0tBrnW6d2uq4HcF2xcLzaiXAhcFoinRF1laOw5Xj60E6EIGxH4t5Yht/5cI3BXvj2LeBYnpvc
 aB3K5eEIgnXibV6cC1BT3Cs6xfVeHKowlTPEBN2PJ59jj2OCv7jKk8wLYN5jd3byot6pBnCKixv
 YWXd1jzXIr0oR3MRyRSb3JeOQTdtGj7+1EVxd2Gm+qL1AOPMnlm7iJOpolSfH2zvg+isKKCGNPi
 HcKHE+9gvd3IEqqlmWEKRkP9C5sBrOX8MwA7Z6gr/2JO5g2Xsb1j/MJnOwVVCGalBtEEKof8SEG
 RniT3B7Unvz8rJY07ntwWAyfnrrE3XsLGjqmExVjTINAjcxT5mSj1/1wo44QXHMNVBt1Ha/vQMu
 v0HmXxyP79ELnicP3sjwsvhuKDbO1Q6txMaHf5f/vK9yAaEX+xUZ88W5wxfA5GLcn0BVVwtCqwW
 6H4grBVny9MkyFm/bsAR/PTGIjgBxHgkJng+qrqS/nT+GTOS1w6/rrE9dmGIxCmcXxhbSz2XQUz
 BXOv/anonl+R/wWz8c2yyp1hSSPxbNDsKq88DjTCWs87fyq6PuU=
X-Received: by 2002:a05:6000:490d:b0:49d:f98f:4666 with SMTP id
 ffacd0b85a97d-4a8e4a0014dmr1750746f8f.11.1795037016315; 
 Wed, 18 Nov 2026 13:23:36 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm7383280f8f.9.2026.11.18.13.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:23:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] bootstd: android: act on the misc memtag and
 kcmdline messages
From: Guillaume La Roque <glaroque@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-3-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
 <20261111-upstream-android_rollback_misc_b4-v1-3-47d17e8a5d92@gmail.com>
Date: Wed, 18 Nov 2026 22:23:30 +0100
Message-Id: <179503701092.2286122.18130505046350302867.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795037013; l=1238;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=QuWINORi322TfIdv9SvaJPf0HzLPszPG5HRlzdr4qEs=;
 b=iBy4ZgeQBvrgiM44AwaAsBC9LYDwMFjDWNBhX7yqhlsS0tZ2NN4bu5Ta77nRyBkPUso1ob/vG
 bcX11YdHrh4DU7glJW1slT0FddRI0L/W8wGtE8K61BsE40WNtiQMbLC
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 11 Nov 2026 10:13:34 +0100, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

Hi,

>
> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> index 3d1e64aa2b41..9f5563751a73 100644
> --- a/boot/bootmeth_android.c
> +++ b/boot/bootmeth_android.c
> @@ -198,6 +199,88 @@ static int android_read_slot_from_bcb(struct bootflow *bflow, bool decrement)
> [ ... skip 23 lines ... ]
> +{
> +	u32 mode;
> +	u64 flags;
> +	int ret;
> +
> +	ret = android_misc_read_memtag(desc, misc, &mode);

Shouldn't arm64.nomte be set when this function returns an error (e.g.
-ENOENT, no message written yet) and MEMTAG_DEFAULT is not set? Today
nothing is added in that case, so MTE stays enabled.

> @@ -311,6 +394,7 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
>  	 */
>  	configure_serialno(bflow);
>  	configure_bootloader_version(bflow);
> +	configure_misc_messages(bflow, desc, &misc);
>  

If we run a bootflow command (scan, list) without booting, the MTE ONCE
bits are already cleared and the next boot loses the request. Not sure
it's the right place for this call, could the clear be done in the boot
path instead?

-- 
Guillaume La Roque <glaroque@baylibre.com>
