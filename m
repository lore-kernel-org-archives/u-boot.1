Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C43CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 18:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44F3940B9D;
	Fri,  2 Oct 2026 18:52:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2JaCrHiOJ5xT; Fri,  2 Oct 2026 18:52:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8173A409F9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790967162;
	b=PSCRMk7cYCO5VgVtzYlIvRiK8I+K8iJr4IrOwH/mDTU6puAcQ6v5dMTshJQa9p6V45Lo
	 PmaZABqD0HPx/en3O8z4Pxa+9S4G9ls0JK1Lt24GykFSvnMrtC7moi5giyU7AeqjUJv61
	 7nJeMkKOlROtw0APldwCvMg/hNDSnTJmgwx8jTNlgy53CwiayFqkkXJSOZ8l8LrGtd/yI
	 LKkMPg5mLV+dV3AcYBIly+LkZwdZYNCPtIny/U+x0INrbHoJWL3e4PlBFI2o0gDvr4xkv
	 XnTwhPrAtz+WZPSoWtoQY74Pnt4RpJ1p0YGSy9sH57asDoSeSxK4ovVuO/pQcinCXOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790967162;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PgiIJxdMieRynj/TXnhHX3pJ6ZVpq0FMsLAEz7NBwuk=;
	b=K9UaHa9fUZh2IvILFzzKGBwopNfd5LDdjyaNYN9uuZaPEl4PzrktpALx7Khmt8YLqvOE
	 URNqEBq47qMZcUGev/Y5H3TSDN1Z41GXoE+3DnWV1ZrK6ee2IYN7ybnwWD8CNS7R7+SKe
	 tg2evIOQQo+m3zF61/C0oogEYtBEa75l5bdCuwyHTkUD4gbizSGxWf8Qx5TXzsfJhpqwj
	 LBLtG7SXHpQMXqGYSZhllShlyaf+lqzqbzWNUJTzxhWINXu3iRa/db5oWqZ7sMFqcRJJC
	 i4n5QkufGJE4nrT0VtJo7FVCcHwJgnYD0uLAhttJ0m8JZ9V/CYx93wMXVvv4sNFaKRw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790967162;
	bh=PgiIJxdMieRynj/TXnhHX3pJ6ZVpq0FMsLAEz7NBwuk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v8OiVbwVnSKtQzCLku6HW/RyFNbKUNuyeFKe5dRR4B1Yqd84PlXwh/2C+cB5Yp+5Q
	 csOV7kpN3YaayntkaaVbM8afbeb+gOqpeDJghFBg7gHIQb0YRUneP3Ze/KxAYcT/q2
	 5M5pFDyMA1g39vFr0/JK4fIs9Mm6swJ+XdcCZxfGeWkz0xrfmHuR3Su/o0lQFdak3V
	 cX0E//3zbnFRrFawBJnZ/HWFQQeHwlUUf8vxOob4+s1OGIrbj2FVqDArRXXkR4it0H
	 1VQShySm7s0j+PA4gOsiubLdBchUksAHfYc8Jy4j/et+bN30LBatT26XRTdMvnIlgm
	 8HU8UsM68VnrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8173A409F9;
	Fri,  2 Oct 2026 18:52:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50888282
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 18:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 422E7400C7
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 18:52:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1Tbadcu7ZGc for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 18:52:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 51A43400BC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790967160;
 b=WJjvO/YRq4k7/9dZl+9nRTlG71qKwu30vgHfALhMj9x239Y+5T69XjdJu+0ODjUD9A7Y
 Fk2wcFqVRLyryJ7v2ED2DUCUMvyUAq/a6CUMk+TtbLY21dfGVsXhTzPk0e6AMDKgDg1xY
 BEY8oURnKw2rWEkjC5jdqNywOUfFSlNd6XRF4MoCx6ebyxsjG7bdrm/RuL0wRpZeLjRMr
 CIQsKJFxOIBDebGLS7zKKOY8zTCT7B4Y1fmEtdYT+DpK4buvM/0efS1QXKg8hNXuNMIw4
 ZP8iddc7zbsQaXFggzikudG2I3BHjZ71URMPpwwftCnUSJTZGHeRIFTowU/G6nLj9Pg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790967160;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=PgiIJxdMieRynj/TXnhHX3pJ6ZVpq0FMsLAEz7NBwuk=;
 b=QltvlT9dX7RIEGs/K3aAJijg4VPUxwcZfFiKg9W2ww7Twe0v+0LRdqTN1vvpRccygBN6
 pBcHYjaD1mTlECeXnj432LrT6Y42jW1LnCW8W/Fhjwi6fuv58D0tUWWqL9tsPrWNVuzyF
 R/NBAx2rPRRsd5ba5tbSsdm50ZeL8Wv2M+jWIqGy4RV0UJ8gGFAULeRVfb+48u4gN1EEc
 V8i4+T2yeh5AwS4ZEAXzLdHpxRJHNSeLoWiSpNLYuV4ZqbZ227FmiDBrciHEm/CQW62Sw
 4mDLfCAWR5rqGRtZH1kmH4DaMbvUt/2CqqSNQAVTarSH+h1yV+bewY3Zw0nVeiIZArA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iwUsZPhE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::e;
 helo=mail-oi2-x0e.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=iwUsZPhE
Received: from mail-oi2-x0e.google.com (mail-oi2-x0e.google.com
 [IPv6:2607:f8b0:4864:32::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51A43400BC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 18:52:39 +0000 (UTC)
Received: by mail-oi2-x0e.google.com with SMTP id
 5614622812f47-4e849c5fe49so99836b6e.3
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790967158; x=1791571958;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PgiIJxdMieRynj/TXnhHX3pJ6ZVpq0FMsLAEz7NBwuk=;
 b=iwUsZPhEbFn6lVslAHlBTQ2nGo39ugqQoeq2ttZK5OXArsAgL1PuPO2OWlZk353NlJ
 xyUI2sdLnacQmZz3d5B8vPqSxDY2A+jjQNJwPSjzwzvOqjZCCJ8StABcv8hXlsZJF6Kj
 7Cs2hdwPZp0EMjaJpt3kv5BKziYZn6jxvsVoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790967158; x=1791571958;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PgiIJxdMieRynj/TXnhHX3pJ6ZVpq0FMsLAEz7NBwuk=;
 b=fRhX1rIvirUEUFTAp2c0Jrn92McT6KHSDdrIV9kfjabrHY/SptdGIS43fp0MwbD1xp
 oCPZxovaULAs0ryAyCyLJNylgtQJPszULtB4XqruoNipH7dO8oJk6IK4SsRb9h4lW0Rb
 Raf8UZiwGBBs8+nwf6RYg6xUzl0lpUPNWvYsLL3Uo7j2K6j86I+uvidOwvKqx51pHliz
 He3dvrCToy8jv5rHCrpdDhaaSQAok+NZBNC05IHrYTw3Lq3xoCSRNVqhovJnvXfM+qio
 AfdMUvYLvM3XqTtcLpWs2oRTyGl0eHVg0dPEQQEyr3SKCa4jG2lTRGjbAuJzrQ8OptLe
 QT5A==
X-Gm-Message-State: AFuF++lfzOM1XKLjAX1vsWrFykbHdUzmxpQJtVYnbjIMWbAQUZkNmXkh
 7fCQgp646SLHbwO6Va3rJNAPKi1S4sUZUldgDsuV0nvp9BeV2UJgDlJR9TEo/tI7RP4NbsgGiaz
 3+qgZ8qbP54nV
X-Gm-Gg: AYBFou3TbJvgvAXC51jJQWXaJF8Lfz9htY2PEuhkPRQeCRuqLVoRx64V1MKg06dde9X
 +wVUi8fuwuRMQP8C8cUJk1thtxosb/cW6S03auXLwW7oyJ6dGXzbPzXXxNEXa+qwLF00RfZzmXT
 INo57Lh/lpgOo62jIH9cL19/gKvLayEt2MDr+PpVw1MzNQ7vv58fP3QTlgEE17Ho8mMstp6PG7c
 s0KbxXwtLgc0T7dhg99pb6ObJm9O6AHCSKm4fIQrm1tK17iZBHHQRwNX5nMQPBJWAMpTlz2xM7c
 tUkuyN1dzjlZsu6jqGo7ut1vFheAqTpCi7WWmWKPIFNrdsfw/eG7F8L9N2UAhtAFi8dlO836KDq
 pQgrP46q91WIMzr3u5miIc+jqpb5fkd1BDOWlvxucer5WlTbj5Zzhtg8JlkpTO2+S6eW/tQNE+S
 0GJ9SUx5PqAgRpmBhyUeb1avgPKI/0egGoxOZeVQLyABsFN43GdfYwSY39pUGMubbO6bpZmQE3u
 hIzKW3R2TvdGb/PPn0m6UnIPpJPXzwd8Ntb6d+zK7cm/1p5dYD9LEw3jsrX+bfxXFVBU+aUJrGn
 qbWcEgS1iccA32yu+g==
X-Received: by 2002:a05:6808:518c:b0:4f4:550a:3a86 with SMTP id
 5614622812f47-4f52aa85620mr2828602b6e.53.1790967158166; 
 Fri, 02 Oct 2026 11:52:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4f5253e2390sm2969574b6e.17.2026.10.02.11.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 11:52:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261001152431.754329-1-trini@konsulko.com>
References: <20261001012043.570450-1-trini@konsulko.com>
 <20261001152431.754329-1-trini@konsulko.com>
Subject: Re: [PATCH v2] Gitlab CI: Temporarily limit thread count on world
 builds
Message-Id: <179096715745.2776763.8119300816667275833.b4-ty@konsulko.com>
Date: Fri, 02 Oct 2026 12:52:37 -0600
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

On Thu, 01 Oct 2026 09:24:31 -0600, Tom Rini wrote:

> At present, our "fast" runners provided by OSU OSL have a CPU cgroups
> limit of 28, which means that we don't run our jobs as quickly as we
> might expect given the number of threads that our older version of nproc
> sees here. On the OSU OSL side of things, they are aware and working on
> a set of overall improvements to everyone using the shared
> infrastructure. For the moment, we want to limit what buildman fires off
> in this case to not essentially fork-bomb ourselves. Figure out our
> cgroups limit and pass -T if needed, or nothing if no limit.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Gitlab CI: Temporarily limit thread count on world builds
      commit: 1c0d520f7fa24b8e021c499ec13b350a8aac3eaf
-- 
Tom


