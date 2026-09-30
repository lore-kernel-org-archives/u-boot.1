Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21092CA5FC7
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 17:17:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F743607D4;
	Wed, 30 Sep 2026 17:17:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fMdxxmjXVTZ6; Wed, 30 Sep 2026 17:17:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 68BD8608A8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790788655;
	b=sZ+U42cRy0JU6ooC/6Jgt31nFOc2b/1ObhzeFTYl3oGtc77b+w6VJVSlo9WPrLwidI7N
	 5chDRXjdrNQ+TtSPqGG6/mmqlBiXMecDbh9moyM3DHnLcmI/2CXwqKnBrQeEKtGdSWe4y
	 bY7sLeBxqt6AV5mDcgcqomxh87CFEJ3R+v7rMQY9upiXezJkUuX/nFtrWgYnqsIMBIamN
	 9CaRWE5+rZmMmO2HGeuuY64A+F6usIuv9Z863opa9Bn8VTjOOZOEez731nIFalNZAfAdQ
	 pE1J6EKeszXJgDyx2NiOyzRQ8GZEB0tDxs3hN+hwc2TS/VEOMdV5mS2hzjzjZKuff6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790788655;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZsBO/OOyQuzHb89ceRL16qWhETIVpi63MCUBdfU85RA=;
	b=FwOa/gVx4IRq1HsiUe79YI9RiitCDR5hJXviPsHjq3FVvZH/G7+zLGsWm0A8kkY3ydGP
	 mYFmutkl+oAiIwugR1ZEXKxfjdLS3n3yWXrLzDTl0+pBJYvE/h1O4vEyiYepoDsuZewnK
	 ZI4XsC2kRJdIMH3LHoMIUBKHfYXkqfWYiT/dIm5vPxu+cn7PlRn+DeI7dKpBcsj2fhE9o
	 RyebKBrfMJT66lU/nO0AIj8bM3p5PwEmW0xelOs+zlrxdAYl4V8Krd30ix/Td0h9EUZnE
	 O0+tFtAy6rSRyUulV4BYHpzIuC7aVgWGtLp5HKkIm9XwWJiJyYAYUCO1SNgC1jNibEg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790788655;
	bh=ZsBO/OOyQuzHb89ceRL16qWhETIVpi63MCUBdfU85RA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g9znblMZly4vcxQu3o37+rY7U34YZFfDNc5gDXP633xOUoymor80FydALaoNKFp7O
	 b8/RuR3q6xjlSVkxAKYTgwN2TdQtXmZzvYm9S4cBPoN9UINkqRrRN55yWXiK/ilVhr
	 IcG/Tv7deOiMDptDFAJ2n1D25zJNcTtA8Zeoxn5SXxv0smSy8eZ9+L/z63nRaf1hEA
	 sztGlbSJb35QtfECoOKcFeyBEM6FZjH5gWe2PGfq0al2uCS7mbnna5E2vR8oztpHlu
	 WuzG1luXSeX1/T87PRWMJczoaG5rLUwRfrvmYbrQ1mHy9iS6xMX5FLuFc4q+B+ir+l
	 eUiFR/tB9mYUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68BD8608A8;
	Wed, 30 Sep 2026 17:17:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F12D94C2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D70B240811
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wl95OimWtNzB for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 17:17:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 30E78407B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790788650;
 b=mQe6bpfL7lepCCqsVrE4Zri5sE6QFp0R9QJ6HAtlXUd76K2LLIGy22EH1O9RmiNRVdqs
 wfMIivRf3gKpQJsaKkzsgBWrHmczLzJWC1RReqVjJO47lvAjRVaCzjvTfu7Q903nB6e/+
 d8NTZH27RmAggzhT2SH+quW9KPLScXWDlKHKbDKOfqhkHBjUtpO1AiifNE6bLARmvlh3/
 9lZfVE4OCFqUopBz5t76/QFOCc+zQkmf4BGOUhd2eLbYsumzS8nipOmNCeRAVcBwrqUAC
 GLerKsb0X+MEiLEef7/hNNR/S6gmPM6I5QQBuhPrXUg+qWNxJYoFqQn2msJtF3GaYzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790788650;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=ZsBO/OOyQuzHb89ceRL16qWhETIVpi63MCUBdfU85RA=;
 b=nmVrogdSNv3KFARJk/0AUUC42xS5SKS2ZvF/2BxYLymsQ+5++V7tJqfNjO3ef5AMrB5W
 caBiVwFZCwZaKuoKeivuo0uFMtgzTmWeve4nX1DDZp2gB0YbuMTdFwNpOPR1Kkq2sOe3H
 N2IYHOxK4kx9zyN6mZyD3jqwNBzrp6iow+iRkr51CQzjT/Ntxi1g3tFMEodASsGq4IR2A
 hGG9LsVYqDPX3tEu7lAc6fNmJDpEGHmxRX3XLKUmQlalDvRI0Nsun6coWnPxLKTZuTTWe
 Db0eMrzh47ttPD4VWJ1sIf8/p4NfXn9tUEoB1KCBG1HXAqQVdKSRREVSF/x2/A6+AIQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Y8IM366A; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::f;
 helo=mail-oo2-x0f.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Y8IM366A
Received: from mail-oo2-x0f.google.com (mail-oo2-x0f.google.com
 [IPv6:2607:f8b0:4864:31::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30E78407B9
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 17:17:29 +0000 (UTC)
Received: by mail-oo2-x0f.google.com with SMTP id
 46e09a7af769-81b15bca7dfso3091337a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790788649; x=1791393449;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZsBO/OOyQuzHb89ceRL16qWhETIVpi63MCUBdfU85RA=;
 b=Y8IM366AitfuhfEjUHrRWqlKPm/mZ3ZKDuKitgzgWuWVmA8RYOkSQT0AGiLZqGRMK2
 vTeCZxpMtQ5qGi+wjE6gUlo9AFBt+8fzbU/Mlm5by7Hvn5WbbdfiGSL9/vEItCV4bwxH
 KwSkaS/kgrU6lv+rGGQql2qSYOlNR+jsDYBFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790788649; x=1791393449;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZsBO/OOyQuzHb89ceRL16qWhETIVpi63MCUBdfU85RA=;
 b=SDdbCqfH8BQMTOwKOpBlXq49/v4EkCAnM9AGDnAMg/Ihu/pmn6887IB/b6dBS/HQuE
 ft5JGJqYQIuQjsCAsWCCLMu/458IWGgInBBrnciL+8VMXGat1qbaZLEFtmteXCidTUVQ
 wVdCExopZLHBTgg3xiXAtdkbxrxGAO1IpX0RR7H0noh9+CQOsUkNlyEj8AVh9FhBz7ej
 VaqOzqNsxEVGpjuRl+qC9vYu6D+lOw9oZxN631o0ZSd5r+yaQoUXoEWGNRFhjSN/pFX7
 7KYRmdR4c0GcOXytMyd7WBYnasJD6A/WN3R/ukKVIeWLeGml2zsjpbMvC/RbXnvjp1LK
 +R7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1Udfh/DsJQdadVFZC+SHnU3pvhCEVE9aH+DhblWUhPokABKKSheHc9EwVMYd4EP2qJde2evE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n0rZhqu9CHkFanhVKNB/1cbtQmUJ2iXtQywqP0tza0sqmL1djc
 1PhDgndCXq7gwDDGiDdrzPrJW9T+/7oci8JH5liL5ysOMXHHwD5fTFwDYkn+XbMb+IY=
X-Gm-Gg: AYBFou381i9w9sE9eDNTET1aWmqbZKzJqMOC67AFLbXcpSvhUXzzal6YoqOptc55o5H
 KMYDYmIsGRRfcht7NA+yYTc4MRfeO/PEsQzYBIEpDpuQQEb8rhgmTH7j2crNADU9f7j1yArRC+J
 o3VwEfQuhSTIyGEQEgkmSTCKur7SITifzXSVzPLLNBJYF2Qk6Bx1pG0/qc6lOB93JSNBJQWBQ5Z
 482Gxqp1oYv9NgXd9eKCKNdwGBBZL3gmGEFK9zlu2Qgcu58LtAgTaJXYJV/AGP5p04FOzMknGby
 I/0yK4CxIPDiGfAfs6/zUfrtg7s1w44kYz0sQuleyzbfDFT8jP7IKtfyaStK1hs0OP9+ITa69k+
 qVIROz2EwPL8atNCmqrJ4wYjEL0FbDaYnzK6lE4Yq/oVY5oQMRxWOctpgCTJPOffx6QzoKunkn3
 Ae6/EN6OyqO/GG+VUIk5Smlw6sE8y84bMUqN95+t9F5lVFHwyH5LHVWuNSJ0DPrremVz7car1zf
 i4vRhXNREcuWOV3ZTjDRv5iavrd9J7j/RKtKbTfNwQ2g933Wqh8fixDBSD9NEmxIyYc/NZ+cbSx
 X+N0EE+olKCZLGYdLw==
X-Received: by 2002:a05:6820:4b09:b0:6d9:7de7:e480 with SMTP id
 006d021491bc7-6dcf4556715mr1753777eaf.22.1790788648611; 
 Wed, 30 Sep 2026 10:17:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd985dfee1sm591516eaf.12.2026.09.30.10.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 10:17:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Leo Liang <leo.liang@sifive.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20260929230758.616924-1-e@freeshell.de>
References: <20260929230758.616924-1-e@freeshell.de>
Subject: Re: [PATCH] lmb: Add StarFive JH-7110 SoC as requiring DMA below
 4G
Message-Id: <179078864739.467656.606801877681278324.b4-ty@konsulko.com>
Date: Wed, 30 Sep 2026 11:17:27 -0600
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

On Tue, 29 Sep 2026 16:07:50 -0700, E Shattow wrote:

> Platform drivers and hardware for StarFive JH-7110 SoC are not capable of
> DMA access above 4GB. This was previously a problem for MMC access then
> resolved by a workaround, since reverted in a3075db94d49 ("lmb: Reinstate
> access to memory above ram_top"). The symptom of this is EFI boot failure
> of GRUB from EFI System Partition on USB MSC with a starfive_visionfive2
> board target that has the on-chip Cadence USB, tested with Pine64 Star64.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] lmb: Add StarFive JH-7110 SoC as requiring DMA below 4G
      (no commit info)
-- 
Tom


