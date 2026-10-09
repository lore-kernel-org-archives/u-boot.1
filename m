Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA35BCA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 23:59:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5753D8138E;
	Fri,  9 Oct 2026 23:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ys06HPdRvQ67; Fri,  9 Oct 2026 23:59:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A8E7881395
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791590390;
	b=MVvr5N5c83HrueD3pWYQ9ZTJd8ySGPA/wGGL8QGv18sTlMvFFvIXp5xaEbpmNIYr1572
	 /SNW85EwG0PG8IoRBIbLmgzzZ6b7dUTArxeZQFYCOHHuAz6OaG0IRtm2UPEGSH2M3cvmi
	 xwUBkOvEaapWe7LE/uA3ZZ+l8I5KnZOJmoGYXiBshbji7xbg/SA0dOo23LgkiS9LrIRRh
	 /v9XTWf569xmDOBLWEGZkezkIxfJ6kRueqQYAbqrWJ7OYfJgnk85iFLcy6jKxAyco953l
	 PcEXsv44oiaO7WQfX8HFZDSx9Nu+yRg+4FWChufvsPf8XorkDmuHcyNJI1GJLKGgV0w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791590390;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VXslcrc0C89piYByKKqHkUsylhkToxnFOMtJkj3nYuo=;
	b=ZSUNEmRwXeRNS1WM9eo8QsjCNL38DZsAHfUVIGb+I3xc2jiC+dI7QsGwJuSTkBTtPB9n
	 j/L3IGKvK6hb65AcI/VNPl53qDObQXc5zjztk4WGyCeQFliERdOAKkKLgZ7z0zhEFk8vX
	 lXQ6lHvOzospXywoU5xUrVaALGfrSFmPnxUQB0gWG7A3nvwB9VuBW8QqVRjxACMcDq0Dk
	 aUHCU9sA0ebOATB3J2YmOXLIbr9gCfPcogTvQOvgjYDC+8c63uvLGkbsns06NpXul4158
	 fF3/VPAsXnXIIg8Oau5A4zw1+subd9lnaH+aO7i59yAhZNsL+kSNj65Sc6lA9m7O7dg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791590390;
	bh=VXslcrc0C89piYByKKqHkUsylhkToxnFOMtJkj3nYuo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iAga0fz8gGB1VPNiKNbt3EZEWiQAFqt+nGVRWrtJm5W1two8M8tVWJSaoykOMk0wK
	 b2ivXFbN1bzDsVB5vb/kekM3pmMaSFBn20RixgG6fbloVXFfLldOw/eMYreMXBLNmI
	 s626nQYdXluxFedKzu/dwEHGOrZ6o2IVRk40tKwbEPY5JtJSykfBsNaVj4xxbNlF4C
	 c1ub8tj8aWIryuQRWRAKYgQ9vOFGLMuUvAV5rg5+CqZuPOAkQfyHbNbfrsYH+nnVLh
	 3yBK+ofEmYPVaE3dGIWDtIk4ee0ZOkYF4y7BY8rSFiU/ZmWEvXLLlXHzwcAajV/Yo0
	 KZLDPk1WEFAxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8E7881395;
	Fri,  9 Oct 2026 23:59:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 14748356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 23:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE9FB4094E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 23:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7MZHDkeGkqDF for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 23:59:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F5EA40949
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791590388;
 b=eZgEWvmNTTVQ6S0/0hcMDB23GmtzzVDJsm8zG2oXFHeNlJxB/xOSna4x0BLLa4MDXDl+
 +hikjvlq9CKPIQDhLMlA0ADRS+kK9PuPXPelU2B3vLnFfYQuPghr5LpB4ganu5nLX4ixI
 e1RZ3I6rJAKYdFGqBcYJfoT2wlE3uJrnYFxer6rJIr05UFsBs7DBD/IvvT7gSkh49qvCs
 hs/FTYgOa+X8aI3R2j0VAYaYLo1PGQluZSA6vCKIuR778o/aihyFgX2/MnEQgdkX+NgmR
 sPDf79G5pHnFW5/afzW/dRYS4TudvGBSEJ3RTJUk/HP81tl955d33y++z4ImBDwu0Fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791590388;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=VXslcrc0C89piYByKKqHkUsylhkToxnFOMtJkj3nYuo=;
 b=QgqnOFSVSZ0W617QgrnpHLTXSuFcpkRclIiYE87dFFJIuFr/biIV+LkyAJQ8eRLncLxo
 RZSvDtuZEBxTrZxHzleFxE+yLzitlsZe5wnFfbwJKdpS9n+t77L9TpxKeSus5vJid5+Y3
 WSfhjc5nNeCNwbaeQF+oyHva1L+LDS3Q2n3m6r+gIHb3ehyGzyPbvA3llc8QkZtYd6KV5
 U/uc45NA9bG3GL3nTN4KOwyJy66ADzKqdfO9NByswGdoqNb07y4TCXMDowb1hw78+Jdu2
 +JclcBaEBnMsFh7YK/2F++yBY718vvOdziUhqG2uRZg824EqlbAEO0CKkP98yrmEjlg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ahjcX932; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ahjcX932
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F5EA40949
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 23:59:47 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-8258ac98bc2so256826a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791590386; x=1792195186;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VXslcrc0C89piYByKKqHkUsylhkToxnFOMtJkj3nYuo=;
 b=ahjcX932UACszqUC7tS34gTpYGM5lzGJT9s+qNcN8zIZ2l4Huf22Ip/1CQhLLqCkxh
 /1C9o9s0EnePH7evu5JvFfkbTWj38GappOorw8fSPA1MCJS29IXUDakzd3/SZF3xPaFq
 5FrqdYj9BPupjkqBkWqOJ2j2H/aDkuekQ4w8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791590386; x=1792195186;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VXslcrc0C89piYByKKqHkUsylhkToxnFOMtJkj3nYuo=;
 b=yGqY9Mo1x4B9UOZX3oc1DomGy1efHZ+OOyUNSTm3hhtWrv5uYzDcR2wB8ijWMFDinq
 wO2Bfub/7oC2UnAPkwMzNsNeRghWlivfO076g6dwAAoyHPkpUjSmliRDuTXopq53Ad/L
 4kfuOP6EoR5yaw9ZHVDuQGcRxKZoFHAUPMbPNOHZ3b9rQk1oxKfCh1O3Qv0rTlwunLD2
 6pSyT7w3qIopHLpMAzEvuPwBoaeDqgWWnwirbRuAp8vLNx0s5MFeVRj8rXG/cEFl0v7Q
 dsFI6g9GA3C5WyOilTXQalW/SxbaDW7UFgCHzODMusWpjzH+4Cx/JZBzkB87rBYK1vUd
 aeSw==
X-Gm-Message-State: AFq9FYI6O7mZUT9GDxSE0APMLPapAk4QGEwaCHEp8t4nkSsBk9JJBO13
 e5cH6oDhBkuf5ZPqbrPTAx7yTbvFCGLsBmi0XORjn+VXlkp+brVdsGlEtRonp67mZY8nO3nbH6j
 X0Woi9dFXdWGN
X-Gm-Gg: AYBFou3evl0gf+CGcniHXaIecd5N35jqWyPhHCiGkncA/rKSfW9YjgShIsF3rY7d6ME
 bHaanboMwxKxgy+XV0mEehBkxFJEyVssFJhkVj7SYtur+gQ0Dv9OoXuNmvnEG1thjsL+FvaJASG
 9vDtZkB3DCwlwHIJNF/1Tp8adwnqnetYhA8falPriQG1RLmMgCeITfu7t0o0/McdFkgk9s++xE6
 uuiplSV0M9DL/9ak9iV9RpbiEso3U24sAKZcQIzlUeikueAcBlcIyal/8taa/h/yYrZIsi/Ow/w
 r7QOL0t8B5IWmwxAWJSk5X0gv8XUEDNZQAbAeL+TSm8nxDBXAAbr8eCtW1YPgsRVxtbus6OhZwo
 0Bmyuqr68N6QF1xKct//asX/h+C52wRmFNUis37D1A67zA/nxSN7xrj54Ik1dPrRNpL4OQV/qV8
 zd/bq9Z2eh1zAku3vY1tUQx9JYAKcJfaq4806KpgtbPN6SbdRrr1A9Rwbv/b7WVs/gBFXtwnN8E
 O7KVwCkDMyeCvu8yKtfbp1az2OQozF4nstAeujuRan3OjW9Vi1XpdpxzkIC5VBjyaXagvKtu5i6
 KJbqkr7uKFPlJkAa3A==
X-Received: by 2002:a05:6830:82b4:b0:81c:4b59:5db2 with SMTP id
 46e09a7af769-83090652ed4mr3293584a34.3.1791590386685; 
 Fri, 09 Oct 2026 16:59:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8303494f79bsm3684158a34.1.2026.10.09.16.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 16:59:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jim Liu <jim.t90615@gmail.com>
In-Reply-To: <ad089161-edf5-4439-401f-620830429ab4@nabladev.com>
References: <ad089161-edf5-4439-401f-620830429ab4@nabladev.com>
Subject: Re: Please pull u-boot-i2c
Message-Id: <179159038353.2945004.17466691372172576871.b4-ty@konsulko.com>
Date: Fri, 09 Oct 2026 17:59:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Fri, 9 Oct 2026 12:28:51 +0200, Heiko Schocher wrote:

> please pull from u-boot-i2c
> 
> The following changes since commit 0a55b098d6f5f6bafa84fc2f18b433dd167bf729:
> 
>    Merge patch series "rng: airoha: add support for the Airoha TRNG" (2026-10-08 10:41:43 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


