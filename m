Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3192CD3427
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7904884715;
	Mon, 11 May 2026 10:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jivrNQaS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E636C847F6; Mon, 11 May 2026 10:44:41 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1194584706
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=h9rPWlKopoXH6FuJLs+wrH/J9ZOnSh1sP40GY6ZknXY=; b=jivrNQaSCIBDjg4ppKrKG0cwcD
 nvfTSGHd3WC3GcrpzuEOcatbVZZG8XkVteLS5FN684MdSakxMqwSvTlJeMC6B6tYvdpPBi/27gzKb
 9LzyqZ20InMoiqlBCjqhpFeOLOjEQMYf8LyQfFkiRYqqtYZfD66qzyqvDU+95/gNnz5rY9iXL2fPx
 sAaal0l0YhL38WZKfNrua74awmKc88MiygGFcD0HrsrFxrvQAkwcJW/y/3Gb1o8o0Q6Sdxy66DomK
 AvJm2uT/4PxStn4O/VsKzH07YR27A+lffTmcoeJXcD5UKvwekbYDJ8vCNA4kDtfZ2uoWOZ7lAaXA+
 20yc7JFA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wMMFi-000E44-2G; Mon, 11 May 2026 10:44:38 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wMMFi-0000tK-2A; Mon, 11 May 2026 10:44:38 +0200
Message-ID: <eb40afed-a4e1-440c-a8da-a6c7e1246ecd@ew.tq-group.com>
Date: Mon, 11 May 2026 10:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] sysinfo: add IDs for RAM size and variant
To: Simon Glass <sjg@chromium.org>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de, Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260508084834.45637-1-Alexander.Feilke@ew.tq-group.com>
 <20260508084834.45637-5-Alexander.Feilke@ew.tq-group.com>
 <CAFLszThq-VrJ5H6GmkgGiNN79wCc09gZ3bgcjxKcUWy+vEEiKA@mail.gmail.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <CAFLszThq-VrJ5H6GmkgGiNN79wCc09gZ3bgcjxKcUWy+vEEiKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon,

On 08/05/2026 20:00, Simon Glass wrote:
>> diff --git a/include/sysinfo.h b/include/sysinfo.h
>> @@ -161,6 +161,9 @@ enum sysinfo_id {
>>       SYSID_PRIOR_STAGE_VERSION,
>>       SYSID_PRIOR_STAGE_DATE,
>>
>> +     SYSID_RAM_SIZE,
>> +     SYSID_RAM_VARIANT,
>> +
> Please document the units, e.g. SYSID_BOARD_RAM_SIZE_MB encodes the
> unit in the name.

Since SYSID_BOARD_RAM_SIZE_MB is only used by siemens iot2050 and effectively serves the same
purpose, it would be an option to simply rename it to SYSID_RAM_SIZE_MB and reuse this already
existing ID, instead of introducing a new one for RAM soldered on the SoM.

Regards,
Alex
