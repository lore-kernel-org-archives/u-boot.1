Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E21606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sBmG+5Ry;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YP4ZYxxB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C556360844;
	Wed, 21 Oct 2026 13:17:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bmd7-SMQR7AA; Wed, 21 Oct 2026 13:17:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BF6986084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588646;
	b=O4BsC+i3uxSIfDlxDjp/jH9EozaDTnBwyE7dpr+mHiLTpqXqgj+22zhBdcBakzwwbmBg
	 v+1UrBvNEzs+gUpOfc2sSSOJwE9my/eO8Si7G5stSe7gB1tO57A6RoSiYAbfZQT+dtCQb
	 0huUh1bRWjFFux2FSVFmlgZAQbrptcCsK/fwL2fEtb3BFgsxQBauYs8J21LVkYJQGDldA
	 HJjRo8Rb8HrmcmH8OfOrU3VuP4I4AHMX56NFvbHNZN2W919/yEakW1gAuQW+ROYca4Vrw
	 HKIOG5VKWZN4nS1bTJbr5C+2iNtJakhpsx9P6ixD8wamt85eW40oDJGBMlwc+ZZYtXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588646;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5q5EqBtSbC6v1WsfDi0uijHbLpJm+ISyTLx1a8k2sZc=;
	b=AOMedwc5FAlLRht62x+y6AdQ9s/PeweYyl5sNNjE+l0jIij4A2OOFrEKdkkIWD+pOoQa
	 D0k7vOB++cM3ye4zrtQseko5EKCxaqrMAYpebPDTcDYrXRje/9uXcg6rc21OUI8FS4d86
	 LzMCRhfTo09z4smuSWxcwNV2IyKTwMXIh5x0DutSfA8Zyzg1OqWMmrTWaeLIv4pmb6LIL
	 HUibuY6fpSgcKzJfd6Kt4x51NxZW3efUTFdk7gL/41xrensE7BSQDHWyIUKKzUAx2z/1g
	 NhHRo5ubSAg8CD0bCDzfGdmiKesWSxOkzYqi4APGJmUdEd+LMsEd37pjySiz9Bhvzlg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588646;
	bh=5q5EqBtSbC6v1WsfDi0uijHbLpJm+ISyTLx1a8k2sZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sBmG+5RyaYRpJ+gOHOvj7ZlOvjXDLn8MaF3o7tzcIdIUBOqV9THDCU9uf3r2Od5Cp
	 DuwnnBx9osAKkBUKUd3GE3IKLJWZp6Qctz+sW0XbIM979ggHiQgiioV17UeD/vFlM0
	 h3pH/FGyR+MpmMiuWbsPED70bl/V6iEvS2We2SuH1Mi1ULkJIuq69b/dOWOkxff7mr
	 DcF0EXic8oPtkUQJZZNhU+irGdHzNqwGoiXNLm5dTMrq5Jp/q8biK54dJJgj96PLyh
	 VWH2R5S4xd+E7gUn2Av7HdGUeYxPgK9fPmo3J1yS0/qPn9RCdQRtzS1BJWlATyXT7p
	 vgexG38dOxRnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF6986084A;
	Wed, 21 Oct 2026 13:17:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 82421E50
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:17:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 682F740629
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c5ryeIq6YOcT for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:17:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DF808405D9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792588644;
 b=Nps9Zy3nefLndLsMWu5j8HIEFL+zenb0Y5FhU7hF98tRMGaOFHafJETZtuBwNTWWGAui
 MZKW0y2EXC8n7Mc+AzMwzY28RZ5sfnvfkDtpJnZDdKHPHBzG9fzk/iXRv7cdgTFOdVsFJ
 EZjuoK4BREaAiroVFPA8kdErvpRQGN/Km/5aIJiYW3SpeiTNvF/JLPxRyeGFRyNDF9RU7
 w30MqqniJtcWwlDpEZcU3zRYtUuzp5DIH/zLMj94up/ob2wUB5D26n87VuJmtzY2Gqe9O
 c57JJ8OixJlg7huGuPH1Z1+lia9bnlnChoD581lmQwnTxuB2QTK+we9w+/FNGrxeNxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588644;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=5q5EqBtSbC6v1WsfDi0uijHbLpJm+ISyTLx1a8k2sZc=;
 b=qyivsZ/pM3gzfTBDCD+i9jMmZmtDkJQxx0N/MjjovtMCYjAz48ibvj8v/NMYGMEy04ER
 hK0Y4XmQppKnVTyY29tAnwXoMM2HsvnI+ynMjtaKZowphBH3uSe4uGcCk3XOvCrRiyqX6
 JkABexR2MXTRJdCQzp4WtFbEWJqs3tHTi5mDPPSPQ/Vl1cFKyKVVAmLB3d5J88oVA3Ju3
 Vld6gPABveHrtojEReyGRoOdzmjDwKA1ASiVw8c4uy26RdNSIZ8umgHVWvgf9eRTOPODo
 cA/GpxoDR81f6ZgZ13pd+GugkyCb9K5AIqbBfuJvBeKUyrWFXIeU3THfKbrF01ibOtw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YP4ZYxxB; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=YP4ZYxxB
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DF808405D9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:17:22 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j8qZR0MM0zKnCT;
 Wed, 21 Oct 2026 15:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792588639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5q5EqBtSbC6v1WsfDi0uijHbLpJm+ISyTLx1a8k2sZc=;
 b=YP4ZYxxBztv+rzQEnbwuMjoM4HgNuZg1F8RZWo084lryk02ptLYIcLP0kIajiGXqgekdQP
 VXR4H92fQEGcxG8UYpPDX6TA6ciZDvF0vWPZRLAClr52czmRENjS/H8r2aVpN+q+nrIkfz
 kf9kTubyuurjxoOZahA4g6u/TvZFAqI3O9dq9Q4yn6NXu1vSayqlyEiH5dW6BT1JiKkpK2
 hwOSxstYTuY+62l8JasRQXSeFbTg/85eOe9W7qXwRde0W4VdK5CphSOm7fFwXrZAD6P+E8
 oLJq6vN8BFDVXRNAJI7E+RD4VIc2kITTPloOQm3Gg5oDQ6hQLj9PezF/2vfAKg==
Message-ID: <e5c0aaef-aadc-4a1f-92b7-b75a7e9aad4c@mailbox.org>
Date: Wed, 21 Oct 2026 15:17:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] usb: ehci-vf: use usb_get_dr_mode()
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261021122134.4139945-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261021122134.4139945-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 672f13aa94d4db824fb
X-MBO-RS-META: 46qxwrku7r5c6b3nn5s7kg3yur681rb5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 2:21 PM, Mehmet Fide wrote:

Hello Mehmet,

> On 2026-10-21, Marek Vasut wrote:
>> You probably don't need the ofnode_read_string(...) above, it is part of
>> the usb_get_dr_mode(dev_ofnode(dev)) already.
> 
> Then a missing dr_mode fails the probe like an unknown one, where the
> old code took it as host. Both USB nodes in vfxxx.dtsi set dr_mode, so
> no in-tree board changes. Fine with you for v8?
Hmmmm, I see your point. And I think you need that fallback from missing 
dr_mode to HOST for legacy DTs, right ?

Can we do this ?

priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
/* Handle legacy DTs without dr_mode property, fall back to host */
if (priv->dr_mode == USB_DR_MODE_UNKNOWN)
   priv->dr_mode = USB_DR_MODE_HOST;

switch (priv->dr_mode) {
case USB_DR_MODE_HOST:
...
}

What do you think ?
