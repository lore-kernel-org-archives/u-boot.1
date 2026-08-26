Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0BFC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 22:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B013D60778;
	Wed, 26 Aug 2026 22:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w3IyveK91Nqd; Wed, 26 Aug 2026 22:33:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787783589;
	bh=3jAv8lWcx2LjreOOGnhhwNeWcz9L9I639FThpXp5auk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mayxX9/lZsy8p842dNRbm1/GEIlTOMosim5ajVFzL2uoXnD3NMQ+Jy7TLBeaTyL3o
	 U1qBMy2jzh33DyijJdx4e38OaF3rtp4XnYtxUTpCqBTkW/5leegD6QDpV4J8OCAV7J
	 B8yetweFiiSxobQamlTuVYnODr0/0dPFMQnMFAZnIokmqvvqnOWNrYFwuG+lMqFyV5
	 UdVVUsP9+fNqOBi72JdXxY7NMjCxLGc/YCiI6kghTEaRwhHgbU8GSVg9MV6R54Z46j
	 n18mWxhXRJm50b6Ua5MUsmwdbOyJzleiwDy5u1ZkfuU7oWP6omD6Bd3h2HSKtuZ+9r
	 QXfkR6BzOwaMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E93D460765;
	Wed, 26 Aug 2026 22:33:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C819323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 22:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E5FC60765
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 22:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWL_1-VMBIQr for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 22:33:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qFuLQZaS
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 891AA60661
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 22:33:05 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4b383347fa6so24599b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787783584; x=1788388384;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3jAv8lWcx2LjreOOGnhhwNeWcz9L9I639FThpXp5auk=;
 b=qFuLQZaSc4H6NZpsw7a2sEtcatOLpjNkOth7J54r/KJw8ploVpPO8zuVZoDeSN4ptG
 PeVcuITyIxfBTrhxkj/FuJL7vSu4sypSSzBH9i5r1JkYpPM9KbkvH41tJNQd5ip53abi
 TbpXU69Ovml2zT6CYICMHC+4RFHAovp9DH9Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787783584; x=1788388384;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3jAv8lWcx2LjreOOGnhhwNeWcz9L9I639FThpXp5auk=;
 b=aUOJP5vwm191dgTNKcAzZKrUF2Uo8JXH2zV/KYjSnMeS6nJp7OIdG1PYHOzmzDtZvz
 qqVrLV94Nf2CknYXl7VwEa+4hYaEGTBbM+g0aOq5FoERjFlaxhhcv1FEUTiQq/Dw9g5j
 pn9lOwMsKSzH49oOnEzt+xUuSSj2/MmZiNFKvXjBpbzlhuZVhYlIp3K5bA/5MQbtg+ER
 PUkSIvvU5q/VwoDkMOCwxabCeZ5HmSmePpkNiOsTzK4dIhkyUexsOLPtuJUNpSPolpmE
 or0omG9Q9jctYQliinOV3CS0rG+vj/GUOENJMrUCTpBQaoq/mnR+l8JakkCAfh9a4gOW
 Pq+g==
X-Gm-Message-State: AFuF++lhkwY7MARcIrZTK2ZUb/WnpWtwPW4tf9yLVAHf2ARkT6aTrVXj
 dDlPFsOK9pmj8ASYm5MMz4DvjeklGEFcqT0Ed7VRWjm2TX2G9S8mOGf+j71zCTi5VZwlYfsStjW
 cR60ACbQknRYL
X-Gm-Gg: AR+sD11oAePcaSt2uK5IyzG/ftczBxjGsmfYeOQ/jYfcv5Z/GxHwALM5p8LJFFbHQ8y
 6dsTyRf8k+2Zt0NQFVAfJEnrnG7+gJkP45D1uXBVBbO/DQ4hNV3LMuVstYR/X/YhlIC/MwVpjU3
 9YPilyLaIKBBeRxjiozkCXEu0O1bWQE6VSd6zM8XOlSmZMSo5Zq7BLqoCZfFdmchhxWjKhKPCtB
 EgW2smxhVepaKL6Bq72imyrkKCWRExVkUe8qTdEuWTeWgiY7r4ADJI2pb7c9DnmG2J44OgRKpnw
 r/SRf2S/OxsIq2kX9902ubtGLmT69NaYpV+ybFrLhIXHjyFW03ScaqX0CpYk7LmNT8/dHtYq8M3
 OPmWhvRbkHghRjEeJ596mBwMuLdtV2vMLjm62OlSTLegaGeWXSFX+UEjOPLq5PdZcorxgRuP57p
 4f+NYcmlQ04zFRbaN0/JWHkdmZ/M6+v9jmTlgBoPvPYlhTw2lLD2b0z3+7rlGjqUhsQvtpU3/AJ
 7I9nxtQtRB3pDm2yDz7flTgiKfVFkTnFIz/9/FUPbQ/MMhJEvUOc31YcdC8D7gzyufRWGcZz4cP
 l3rOXUdm
X-Received: by 2002:a05:6808:10d2:b0:495:f697:92d9 with SMTP id
 5614622812f47-4b37c88e895mr2559868b6e.7.1787783584049; 
 Wed, 26 Aug 2026 15:33:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36a7b3783sm2970930b6e.8.2026.08.26.15.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:33:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Daniel Golle <daniel@makrotopia.org>
Cc: Eric Nelson <eric@nelint.com>
In-Reply-To: <blkcache-hwpart-cache-key-7dbc6a0e41d@makrotopia.org>
References: <blkcache-hwpart-cache-key-7dbc6a0e41d@makrotopia.org>
Subject: Re: [PATCH] blkcache: include the hardware partition in the cache key
Message-Id: <178778358309.3986699.8501304820655754382.b4-ty@konsulko.com>
Date: Wed, 26 Aug 2026 16:33:03 -0600
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

On Mon, 17 Aug 2026 17:50:27 +0100, Daniel Golle wrote:

> The block cache keys its entries on (iftype, devnum, start, blkcnt,
> blksz) but not on the block descriptor's hardware partition. Devices
> that expose several independent address spaces through blk_desc->hwpart
> therefore alias each other in the cache: once a block has been cached
> for one hwpart, reads of the same LBA on another hwpart return the data
> cached for the first one.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] blkcache: include the hardware partition in the cache key
      commit: 65965f4669490f81b0d03fd0db42328002b089ff
-- 
Tom


