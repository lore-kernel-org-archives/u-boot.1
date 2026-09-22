Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543BDC982F0
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 00:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D04DF407C5;
	Tue, 22 Sep 2026 00:40:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cFxGOOd3eHnr; Tue, 22 Sep 2026 00:40:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 169A24076A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790037647;
	b=O78KZR8jWwPzzA41nxRPly6A2iRpzNdlHevlfST0Qmmn3rzIYV3k2nMNLJIxQl8/N9hY
	 UiJoXu5gfch2Qp/8/I9H0BL43tV6wIK/znhw4VUaH2n+wwP0ZEf01cJkOeaAjxS8+z9P+
	 ck+j9BhgMYJXbFt70Pb7pRZKlGEhwR/VV46VBVEZpXNO3ZlZPO60mfqK/Y2bv24elCC11
	 soI4XdrVRLfcf+9wAUrzo7bpp0R9XGWIX3bh/65csv8hSjGuIszn9fvTMpAX5GiqN0WYo
	 kqSdG3++lzfW/7Dm5+m9qUwOXKlmS5fq/usGqhu5E+9dY/uemZdwCnM4fLbURTdBxNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790037647;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=or3lr97In6b8+mBM4oPXVCVsjIFBwgvLur/xmsnJ7Fo=;
	b=bViuvJ0iq49a7iX7JnumVNd2hqtPDKOWORPW/7pbihhVoEPgI8A3AHnrdMW/N1Y0igjb
	 irQWHFIvfwHoaTweKN2oznKLtThq/GcPkY6eP+7a29lWHPn8ie9wm1AlUYy6k/M5wypE+
	 mET2fCg0neIdx9bzxOMmDIlZ3YXmSd8Hmhq907874QQBntatZSAOzdSMRvh5kvx3qYg3A
	 QWdxoi2Lf7qcsUorngbeByIH07xKVVlWBQGS5CZwAmzAp2cVE+UJQ3zN4LwPbQD6kF03z
	 zbfuYUbsbBGPIH9N6E+qVhFSSonnM6wFhuz096oIdR8kVVhApNkAaKqbypvyKM1ItvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WsUpH1xr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790037647;
	bh=or3lr97In6b8+mBM4oPXVCVsjIFBwgvLur/xmsnJ7Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YGOYs4OLZ/36rskeh0cwywbN3dsiVeFjVKNWocMTIz8AExXTWvq0IFgO77CF04yEE
	 vaPoQ0Hfoq4GwD1b1MRfQXczeytQK0GY+25LGo+Em6muXFMx7i8BGUJlfP+BQqZJkG
	 2tul1BQjFeqprUdcaT5Xsf3a5j/IPNvDd3sdaQgEOmX1ExqPmfu9j18W5LPBoNNLte
	 Cr25JrfB2AX4wa92OmlZLhwJ8IwmtvTvPoHjhjt63FG9PoONtL5/NKPI6hVeuZgyLT
	 B/u1JOR6o6zK9koZiQDxGvTIlPaKl9DPa2W38vn1a1FvWNYCKQPD74oeGgoMPNRZI5
	 +m69roOIesCmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 169A24076A;
	Tue, 22 Sep 2026 00:40:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4133834E
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:40:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26DB94076A
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O_m_n-AnQyxn for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 00:40:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6AE364074F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790037645;
 b=paggBf/VQ1M1Fod8xE28joBEckWmq5ORqHvBRAZPe6jRRmrWhyAJvTgWers3wLcmP/gJ
 1YJoHNtlmZKpeu9ec0lUc1fFWR5QOg8N94MRNPKQuPXDIu0j7SC5Xukrq6VfGfme8oJZe
 X3QlFT1CMRwIhuMq/iIkCC/AtM8+Y4sRsrJeiVwAaq2REm6E4ThcvYmonRaH6Cu9x3CUc
 9ANaK4JwoMqGjUeTz005GGoSmVUblgJVq/dThNGfnuFz239K9AaK/7d9ZMNYjZFrHBHJE
 jLN58pU4/UPjV4K5sBkSOG9+B3EYCCAEeMtdvsZlKYfz58DqCh+OP/jvYAghvbg4L2Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790037645;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=or3lr97In6b8+mBM4oPXVCVsjIFBwgvLur/xmsnJ7Fo=;
 b=Y4JlhjMvJTkTNrek6Ov1jKeLcyD7AoElVgb9PQ5htTqlvhzpGn51ERIohCB5olejGzKm
 J66TxFp6DgTsT6a+UIyeTnpXws7mCRuqviJJjPcU9BxTQoPLyPBxeEyV96IwY+WELSHny
 g3mg7Yf6t53fhdpXvEA2edCgtJHYIYmPb3LPqaDVD0iOsOpBG2+/O9QeAXiMSnGd+uuFT
 +/Bvl5DcCaDmraMo8070BwqhY7bh/3leHu7KATDfhjcdEQTCfZOWGewJ1A/9a6ZzNXq7X
 cAHqmTqP3Zi8+Rqd36xYmXXmBROkqqzj9zkqHM0K1uFw/N7j3Pe43HV/FfjDhNLFYhQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WsUpH1xr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::f;
 helo=mail-pj2-x0f.google.com; envelope-from=hungen3108@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WsUpH1xr
Received: from mail-pj2-x0f.google.com (mail-pj2-x0f.google.com
 [IPv6:2607:f8b0:4864:39::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AE364074F
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 00:40:44 +0000 (UTC)
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2db18fe459dso21228055ad.3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790037644; x=1790642444;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=or3lr97In6b8+mBM4oPXVCVsjIFBwgvLur/xmsnJ7Fo=;
 b=WsUpH1xrS2iPpQC8Wq+XDuGr/N78s65wXih/DiwfoAsXYIHnNFa0tUFo3Kfklv7/GK
 0/J0RQG7xZEZz1k+J8RygQjEs+rlVe3Ij4vlQ7gc5KlafTu28fJ8zI8E+7rgujyN1sMP
 pcsWPpXxOnZzHT2cJUCfuuaE5/JdfY+0OFNpEYNPtoBghckygzmfqj8L1RiAmR73S6Z5
 J8uZn0CJlICehz4UKRAe5KSVpyIg1hi5qdbGzKiLQhZruZusX6NpgM+Lw826xlH9P0gG
 AZilzzKQPI97tsvQLBhtpl5xWu9FM2jf30QFcrRxmV1wr28F7Zn/Mtxu5OP5kTpWRKsA
 phtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790037644; x=1790642444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=or3lr97In6b8+mBM4oPXVCVsjIFBwgvLur/xmsnJ7Fo=;
 b=u88Qh7i04xBLBWV+B7UaF+ksCJf7DxQIM//Pqlazw8Ihi/umRr/USb1rw/tGGOLP77
 DqMdshQy89hUcK5TKw1MRJ2b//OLqyAZ54C+o2sh2WAt3rQOZxWm/Zb0fv0B7oviDRVT
 +GkBBP91NPjftm7fTFe00JfCEZ7vFLSdj4WIdjQHMD+WtJs+laSA0iH15RNPA/r+8/Uq
 DxTYFNh7r3T7Sorh3SV/nKt0UFsbACUHI6j2f6+skN4rHi2Fl/XYJdo/oqV6VcTwfDRu
 dE9eQPsJRJZzviDRN8K29NKgj5rRu20am0vhNC5WM6h2jXIL/rzp6jfjmgadnH0f4K9e
 CwvA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZhqRmKa9qjN4Sx++6bzuPWXTqVRh6Ligy5OwPQ9tnx1MFnOy7uovVR/VesPYj+QWRTyKouQw=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mSzRzqdx1MVg5JSHHWPxkT9lnwmh5QQtuB+SdmMJR9CYSuZYfN
 Q2nNwoDhxkahCTY43IefssfCzIOysy/cBtaENwoU4dEZ25CdQHSgIgfR+Es76qzTBAYSZQ==
X-Gm-Gg: AYBFou3afdxHZi84N5L0s3fqzMzus/dDi4ayPLq6Dt5tTgXEJYOTAPHR00nVGhb3voE
 BucVSN5tqiqQz/acnGI5cgyVCWQlFCZKAhcEmu1BsO0uuRK4qIWz9Rw2312R15MQFrbvOy9T+QA
 6/s4pUrplOvaWNN7d0nnMnc7dHi6P+WamCWwcNzByYz+enXUeKK3qjNpA4UIZeBLOz19lQ3rFNk
 0eNZqSHLqpHEZ2EScXgyFP+TJzmG7dQcgHvF5OBJFCot6ljKvFsotJptHyUf5FN/t/Nv7L047Z8
 mTqiX2gkhPVwmtqFNlQxh1F+gLcpzQxOikx65blzfIn1sZqwh6H9rBtqhjykklMxoJBQxcbpQw3
 XCFI7qv9CRsPW5wplK2sAjoYteqO94098AExn6t+7iR5rj+LonEY+4Qee0eE9r9po19yRVUxhpo
 kYXEp8UxRoQxi8wT3r4JqfpnCSH6TTmJS7FX5dk+qUeJdLzJ5Oz1ri47J2U6drca5rzRxw7vKZ/
 W9Fe7rjKOYUlV5ZSPFhbRoP0V6GKjL3lNN3tVPkjYHz9LZOgU+Zkb/RTkvwvP5akzYewbUIcSzZ
 7jFVkUOl
X-Received: by 2002:a17:902:fda7:b0:2d8:d4d3:3fbd with SMTP id
 d9443c01a7336-2ddb1b79273mr179797435ad.17.1790037643859; 
 Mon, 21 Sep 2026 17:40:43 -0700 (PDT)
Received: from pc130107.ADVANTECH.CORP (118-163-147-185.hinet-ip.hinet.net.
 [118.163.147.185]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d030ea6sm676965ad.44.2026.09.21.17.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 17:40:43 -0700 (PDT)
From: Tom Hsieh <hungen3108@gmail.com>
To: eichest@gmail.com,
	marek.vasut@mailbox.org
Cc: marek.vasut+usb@mailbox.org, stefan.eichenberger@toradex.com,
 trini@konsulko.com, hayashi.kunihiko@socionext.com,
 u-boot@lists.u-boot-project.org, Tom.Hsieh@advantech.com
Subject: Re: [PATCH v1] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
Date: Tue, 22 Sep 2026 08:40:31 +0800
Message-ID: <20260922004031.704968-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <arD0gD8AMpO_B6kT@eichest-laptop>
References: <arD0gD8AMpO_B6kT@eichest-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Stefan,

Thanks for looking into this. There are examples of standalone
"snps,dwc3" nodes, such as rp1_usb0 and rp1_usb1 in
dts/upstream/src/arm64/broadcom/rp1-common.dtsi.

What I am still missing is the binding path from such a node to
dwc3_generic_probe(). Neither dwc3-generic-host nor
dwc3-generic-peripheral has an of_match table. The direct "snps,dwc3"
match is provided by xhci-dwc3, when that driver is enabled, and uses a
separate probe implementation.

The platform binding path I found for the two generic drivers is
dwc3_glue_bind_common(), called by dwc3_glue_bind():

	device_bind_driver_to_node(parent, driver, name, node, &dev);

Here, parent is the glue device. This also holds for the flattened-DT
case: the glue and controller devices share an ofnode, but the controller
device is still bound as a child of the glue device.

So my understanding is that merely describing a standalone "snps,dwc3"
node would not make dwc3_generic_probe() run with an unrelated bus device
as its parent. On the current normal in-tree binding paths, the proposed
driver-name test would pass.

Is there another binding path you had in mind?

An explicit check could still serve as a defensive guard. My concern with
strstr() is that it checks a naming convention rather than the parent's
role. If documenting the existing assumption is sufficient, a comment
explaining that dev->parent is the glue device which bound this controller
might help.

I am happy to leave the choice of guard to you and Marek - this is just
to clarify the binding path.

Regards,
Tom
