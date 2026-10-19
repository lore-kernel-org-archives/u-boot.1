Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E256CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1601760743;
	Mon, 19 Oct 2026 08:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IO1YFTzqVOoW; Mon, 19 Oct 2026 08:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7B69E60752
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792400283;
	b=rde+BOo2MVAk79+jR1mPkR1aWorWYfXmaEc00mu2EfDIxemiF4m2b/eoh3lEmacrNySb
	 11lUPeR90+3MFJbQgp1wuw4meo/b/0oY8ptJ8Gb+OiuJmMsiEPVPAsyMQ5LJGrqgZrNes
	 bP1otCPP8HkFiZ9aS6ksEjsfGWyxWAYmSVsj0cGrd/Ung/pwo1+UzUBRJVvN1jgKT0mV4
	 6jQtHoFtEohvzkrROmkh/03CXQjWoLmCh5NA4eUxnSK3HLQ6UNfC8pKP3iRzbYyV64WAD
	 a/4OrLdJ8vvhJJwm6/VSmABMiYgOg5/oADaqDC+aDKDpnX2B4KavKM8yrwZsyn/02uA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792400283;
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
	bh=D8UVmi0nHj6dCILnLJmWQKpP6kx97z4CmSJciWw1RpI=;
	b=T4tLBZCBkW01bN0OECzcHvtgQrZJy+qCrOt3jHOT+2fI+GRDB8oDYEe1zgcP4q6gjeIx
	 BpFM8LDxoj5FvN5Nv3yMeyGkzatVMOBU9K/oBJknOxG2SZFaIu2PuneDWnZ87+Srapumv
	 4IwmCL0lJo1sYH+oXhFL/xnbG3pZjHlmVb5rQXNPVXsCzMAcHf43IQOqSvuZBaRr+tY5q
	 zCsv0evoMbrrE685t/memnjB3hT6sEefYLItGE0D59oIZEcvT7LPX21Dcv4U8RBtTiuzW
	 wvzb0/9CpCVggEmFgGRcs3NEhoM9zUh5Q4q9f2rRPBqZh4zQSZ+Mdwl6gYiE71Xu8WA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=mFJYT+gr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792400283;
	bh=D8UVmi0nHj6dCILnLJmWQKpP6kx97z4CmSJciWw1RpI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JwL0E2nmvAP/+l5VRHA31aY3vZ3hkcFuu0Jmramqj6FWa6MwCNOWVEHJleKDyIctW
	 QdTkjboo/jRCrfhfOjOOv3qBdE1d0YUh4mIClYTySLyZedy4P91bJh69Mq+TC61oi7
	 H9yfXMl+ZYRqoBLOZjVyCQH2jCNfn2q2CabrfOjXyoXLYGD7dhUOTgxx2jffgytRyv
	 BNJYa1ZNSJQl/SM+Tz6hUHD4YpOOohL85OdbN5AfBSkfK4AbZ689B5ypJi/CYbDAJq
	 0Xj5zyHB1tWNYmBvS+4tICe78+6ZFcnxgMldWUypJ6b8997CKkacuV4Vl22bAkSuto
	 M0oFjFl5e0wHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B69E60752;
	Mon, 19 Oct 2026 08:58:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 805392A8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AF7560771
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u_cEDjF56n1c for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:57:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF853606CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792400270;
 b=UcX/qUYwn96LagvBRNDSOTMCPiNH/cmn3aYVfxUrLuExuBR1RNgBFMsMY8dGSDiKgvGv
 k1eaCgKkAJRzHguKjLBwFpuZxqScg7TbjS0bIHwxJxeBmSO1TSWeR8DP3ISua+2WFh3tx
 sGexssBR1A+5IyihkWCpP7CtBC2wpZUb2hV9z4XEg3OWoM0T8oW2JVBm8paDVzah6nTkb
 kSl0iX1NBv26eV1FC1mddhwXgxNUQemm/xaHdmB4HPw+6+L8n09ZNvDZAJ2iGcLnN5OBE
 4LpnZL7MJJQobnbuzsZoVELwDWHt/Rv4WLkpAzVtfx3oM+ARSlXYiKs/CktgTm4d5GQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792400270;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=D8UVmi0nHj6dCILnLJmWQKpP6kx97z4CmSJciWw1RpI=;
 b=GF4/pH/6Q+DrpzzLLllL18lbJ6l60RO3UsSUHAHBfWcgAPcgxfTt5OYZGPcEABnLMhfq
 goVX5QlmIh8dkoXeA5SNOHsE144cOQgFHs/7fYhsPj3VpHkLucrDMweVAcWHNmFwIm65L
 Jjiu3DWf8s7r6lc7NOeTAKjFcdsERQK5YFSb4jRySTDhhmRrsHPuaSLl3PIZgPTkLC/IL
 EyAtUVEpC56suPvAKHR2U9kY6yn8YylrqH+4im2oOYNvjo/sV4WZYhU3oJOJN61bKxi6Z
 O0YJeRm+tuMo+y4Om3FY40wGUcinYCD6IakWI6xA6j5GNDLvxlRXIb7YhAc/HjE7JTA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=mFJYT+gr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mFJYT+gr
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF853606CF
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:57:49 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c40447e25e6so206629166b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792400267; x=1793005067;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D8UVmi0nHj6dCILnLJmWQKpP6kx97z4CmSJciWw1RpI=;
 b=mFJYT+gr1m1kiHVsFdfOBC6Z17393XycntJj9KDerrI48loi+/W0QeE9llkd+zdRFG
 s7kCgoRmpoBlBt30eRjtSM4GEr7ohtAHoNBPDK+iV6V09+CrVugpdRcU5VyZ5htodYrn
 N8N3+0N7F/3FIOno3K/3VPy8lFkZcMyCeHGOJSf0qiOwHpnRNR3Nj6c8tqWI8YGMk5Q/
 B9aeUvA6xymhjz8CNFauNEs5X3ifRHja9Fhu5hry+7psd+uGStXhRZoX46uLs5vEyF1q
 I0+/ew5iJ6VVT7t5UIIh5BTJ5Ig1Zl9DrDJBv1G1WUAvNGd4kTrbJCaF4NYMStMU2LwH
 heSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400267; x=1793005067;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D8UVmi0nHj6dCILnLJmWQKpP6kx97z4CmSJciWw1RpI=;
 b=ONRwN7L+HHeiFvwlk9K/lqM1p7Zv/fJoTZYPWESDXkXkcyLa0+f8eHBwcFo3x3lSgm
 vNOsJdZjOdktvSQoMffqp9pp2eMb/NDdfxE+XnmhIIEJGi56r9Vdg0C83NHIwlbVR9dI
 xwyMoLso85cXVtT0ijcOn4zyZkx1vJHV5R4R4YNsaPlNmQzIQY7oVtI40H9k38rPt56W
 1YA/y7S9cctDaey6Mm4oY7Xvev6YMGPGhTWWQ2hWVLlXqiX+gPs2juQYiJr+iP2eToV3
 UmpoAO8yzSWQAA7TiNH4Xsbp3iFhlj4f4h6WSF6ZBCqd+k4FLdnUoicvydFyi9mNbGPX
 QO5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHnSDGPINRX8WkoLCEZezGfY3QgTMt2D4/BtwKHuWeEHMSQbHfmJWgxzkPcMffhHjnlJqlJlI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIjYVUyUy6ItWMpiuESP3C+x5Fujs6+eMUGe/u+TlT8IOBgtJYf
 T5oTp7w/zvAWS1is5o2vxuWjH6sR3FdEJKO4Slmn6b0R6NSXNuNAIhyaGxkNUq35KHA=
X-Gm-Gg: AYBFou0TdSMfjT6F7F+Jit0wkf0TMhzssDLX3W7Qsrk+pHKOlUrgQCse2ClFMC2iN/q
 Yknbdwf5Au1NOK9D/2vukVkudp88f7RQVW//OO5aKblxFLZ+L7rWwDJ7xhFXulWB2ft7Ydtj56l
 iT6zZ2AahmzvnPXBqbUaTqPmkoHOe4qlRPyrEQYN7L26kc+obup9vS0URtvSxk1TUAHWxtZP34e
 DwBvhnH13eX2OYzb5zptvXZKv9iZEwkEaXLdf45vmA2Br2eQlcAz+ho1FxbGvUUFcnrwYXG/fwc
 nfCQT79n74DIY0fZNFgpbys5SZh4ut+/drjI3IRoCkaQnrUsbS23IapojvBIFZKk8q2IeB26Mz+
 3ctpIoJnJZfQTU42qI9lWoFGTgCpydvP2pHbg1nVyBnN0elkelLAY5UyUQAAOvG6Q6PrVGpukPp
 ck7cgjft39wgMVajKtbDLXUFqS4NiFsZP13YILysuxr6DW3BGVKCo1jusaiC+bRVJd9I05T65fq
 2vo7O4IGjXr/SKiQMWa
X-Received: by 2002:a17:907:c60f:10b0:c3f:8c92:3b5a with SMTP id
 a640c23a62f3a-c419df3eb40mr295189266b.12.1792400267436; 
 Mon, 19 Oct 2026 01:57:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c408e328527sm338958366b.1.2026.10.19.01.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 01:57:47 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 10/10] test/py: avb: Fix find() logic when matching
 response strings
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20261015-test-avb-fixes-v1-10-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
 <20261015-test-avb-fixes-v1-10-9e5b82644359@kernel.org>
Date: Mon, 19 Oct 2026 10:57:27 +0200
Message-Id: <179240024785.806974.9947901337556973403.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792400257; l=278;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=M35YB38Bx29ImsxEdfwlu2/n6XJqQbrgKbAC/5xYe7g=;
 b=aJ8tX6ZRKGQQL/UkJsBbUpp2vPi2A7Ai92rgW/WCGu58Tefr9G21RaVYDnqNU9cr9YNMlIK5N
 mYV/cs3AkDzBUTsWnvdYBIVM34oJe7SDDna9RYCjvZVspfzBHY/PYfk
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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

On Thu, 15 Oct 2026 15:55:00 +0200, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

Hi,

ok for fix but i see last one assert response.find in code where you
don't do same fix , any reason ?


Regards
Guillaume

-- 
Guillaume La Roque <glaroque@baylibre.com>
