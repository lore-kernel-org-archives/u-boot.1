Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D7606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UKzdDvnr;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=hpr+jQBf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2485481004;
	Thu, 26 Nov 2026 09:13:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S8q1c5wqSdbi; Thu, 26 Nov 2026 09:13:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 442D181006
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795684431;
	b=AaXXs9kT7+IV5+/Tn8nz1WqEDFLpX+kxI9THTyuzCldfOQZyLCATVH5BnViGwvYTU/Kl
	 ybr8s9f7cCyui7VYEBtk8tpi2+5dFpDXA76DC8D3IbGEdjx3UXP/yo9s6O52g3PMGTvpR
	 Ty27mW9NcYOrfvi9T1VGEz22/cjTaqITWbLmyLmNCF7TiLVmpiRBZlNR57XoVqO1cCdZX
	 wdb5tgfnxbmBwbWYdPLyPzZq9haBICNicoYVmjMcrmjxbznT0Q6rZb4hwSBzJpSFDet8i
	 Phf0YkU9dAElhaMaDrRLaMowW64PnGQW6lZKwF5M/Ktlnr0+RxdyEjFDr/Of2t8yHtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795684431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=n+wbbgIZVAJ/XsezVnvAr5CGjVB/t9sEdOsR9bg6WY4=;
	b=Ko33xiS52G5Wy/vsFYoy9BUw/9CBMnUdlYcRX5moF9Y5a/4KyFjCS2R9LeLAL28UjaUY
	 feoezY7Akaq1jDUK25MxpIfUdHKZJ820DYsCcVHP193H1+DwD5EBqBOhAXzZ9daYolsyk
	 g1mafFyJ0uFSvzlhMXt6KXs0O7Ug6yV5t8olYXNM8PAgqZ62Nt7NGaFePtAOLxm0av7tR
	 IV0qQ6g7OPnP9wItHE/BEY4k9322GZYE8tceWCzHGcZQ+4S+3PDsXTlyykIFnSSluJJFu
	 hxt8s4HGPQxjbZLR7uPGHisIuGnkt7YKVKxgWZ0s4P4BDOe2f52yow23W0STDAS2jAQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=hpr+jQBf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795684431;
	bh=n+wbbgIZVAJ/XsezVnvAr5CGjVB/t9sEdOsR9bg6WY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UKzdDvnrXPBJRU+/8+nVeXBzqRF6d22RygXleyqppBcaQ7mk924+3w3UZvqpX0NuN
	 CMNH9Bme/L/P8eW3pkRGcxX1KAJ+rYgGS1aH/cRnDD3bZBanzcPe9/CcqYmUJS7qAE
	 GJj/Gz50sJ4mv7YVD8vCRQgmo6pIJ5a17CzvUbNcJCI5DS62DQ2BesnVScge8zUGsH
	 +sv+pzBPDIy7XCDk7mJMJ8depj1OYas1qPCS+/xA55zhzRW1xyTV4etanJAOBwTWQ4
	 NSU7p6scDd559Bcr4HK9ozqzsGSpt79khXJBTh+NOPp4Uds7R8aRYNFr0X03rTixpr
	 aRRCHYalsl52A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 442D181006;
	Thu, 26 Nov 2026 09:13:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C87410B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:13:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82A2681006
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:13:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nIyR7n44nFeN for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 09:13:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA2EB81004
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=hpr+jQBf
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA2EB81004
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:13:46 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E99E73F641
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795684423;
 bh=n+wbbgIZVAJ/XsezVnvAr5CGjVB/t9sEdOsR9bg6WY4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=hpr+jQBfBCBcOBVcRRoqfJQ9jBINtSgo2oKrUIkowIqtBFFPDelCOFxETekcf1L4T
 sHcIEFMFf3gJqkQfBP41rIA/CnP1/0auYAgJ+/ocQbFofTu0eelHqxQH94tmxFwyIr
 BmXT5Venpphtkowvf1sVzV08Z4GLnjodxylrttZaxSTNWiM/+kQkEBp2Me7FRdUuqk
 NVznmeAQ7cHR53jLUulUR91+bjJonVaFf01aRZDEhERpSOeI9vP0kn6vrqlauJzff4
 NUImRlT1U2E4Y6L3hc4FIz9eZAd390dfGf89LeDQMbRZeAKMI7Ng5EoY/dZaykcwvY
 S4RFyDpOW/9hmNq8yRg8aHAHEFqHdU7ZVuu59CqJ8MKTSJK1p4fkuDaFJsRfyGuz+7
 UykRiPz7VCVvsFuE5z0AJMJuH/47nNG168d6CZ3WH9A1DVc5vjjiWr0iTACd7um2VW
 BZWQYljiRmRIjM4pfYKzGE+1pfJ4lK56xOd5wDK2JEW9GfUxniPgcJGMhOhgFqSx5u
 +Jn8JcGjUifVqK6/rP3IB6If+kPWaGxVrc/LQ3zDTXNhJ0YcT9WGiJ9AEY3vnsgWrD
 SjRnlKg3ooKwvo276lcfAIzCEPayOz4FTqUpiDtDIOtdwxdO2QK+edbdkF+S/Gebz6
 DygEcY9trnboZLhmbVF0cRwU=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so52539525e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 01:13:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795684423; x=1796289223;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n+wbbgIZVAJ/XsezVnvAr5CGjVB/t9sEdOsR9bg6WY4=;
 b=q0gc8YeDzORXJqYTJGG+SMQg14rUgByDRinPso1Sh6L3ZRKsAspL/HozBU/ADD2KHX
 CDAtUF7H+4JqH6AGHq0t/nP4Ij5KW4G+bcIpcniPCPu/p3KK4qT6aGINMVYOS3mIKTEB
 I5Mdeq7WUeJpLjWsBNgehWneoIGCKeU6W4phPAQznB+tcjedVeYQ1D8ELEZJyqGmVIth
 ygw7ehAeQ03U/Og4U8utL097Dcir4ZhAU7E7iDMQ17a/l3m+8MQSqCdLEkKGTVzBnc9h
 ksBvlntXHfXqUeTdMmdyCMZfQxS3Rtg4wFJ7aHf1BgiwGD+38tbxukCV0iEfN6x2hVMP
 Z22g==
X-Forwarded-Encrypted: i=1;
 AL+hErHFpkBKlRQdfrWCMaUnUiTZdC7bPkLmRlQstKHl3D6zUDlFZxG4ryfUPHF/PVL8OQuXCc+AWY0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/5F6OJX0Kq85wk52u0oyypRbeT8GNclG4M7FSgQmow9xzA0BVx
 iCWwaB+E+htwXngS23KVDcsDmbxLH3aynqqmng+dp8MGs7bZqM5RBFxsFlU/3iyFkM91vFaPKsy
 QF5goFK+tW7PUu+oM9umM501jFxn3YJRSAEZQTqqwjD/YSU2+25oYUzwPhPHoQQNfjoW1exnl9j
 feHSYIxAbZSQ==
X-Gm-Gg: AZFdTZe5gliHCQwQ2X3JuhDxFHcMi9D3HeDJCFnXNGc0w6UdBbUEQNGzz/Dt7YaQvFQ
 OuWwT+4m4wGa16nhceuvva1bS8W6sabNJmXtlt39DhG2eArlho1JEHwGupTaI1twat4IcIPU0+4
 bk/0MTQAVlmvyH71v+sr3Nvuitp7QdwgABwD4wl1r/AjtQwB/3sCmk/Xsyq/4VGtDNielumLlFi
 arUp1h8taVg2GTYrM5BaMaCa46ZSkpVI05O/11KiQRmJea1gY6qDT1BGSIhRvfGnSoBpo7EYcdh
 9SP4k/LtIweYqajtC79XfVNPjtnWLJuQ09TvbC/kgd5jtlDM2EoKMjYHJYFjA5oUlDVmGBT5Lpa
 E5Op1gSZfsCSp7xe1RpGJDZCYb0PGwlMuCapp5Hw23JRSp4H8CBG2KHX43I8tI0eKmtGir+UFiL
 wkylwPbE3l8arKz38FC9+19Ij5n5tMfHW6gvEmizAeCL/YGqfQ0sLPuPh9JrX8EyQbrlto+g==
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id
 5b1f17b1804b1-4bb888160cdmr435516165e9.14.1795684423612; 
 Thu, 26 Nov 2026 01:13:43 -0800 (PST)
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id
 5b1f17b1804b1-4bb888160cdmr435515745e9.14.1795684423263; 
 Thu, 26 Nov 2026 01:13:43 -0800 (PST)
Received: from ?IPV6:2a02:908:1242:30e0:3b0e:99ad:b595:81a?
 ([2a02:908:1242:30e0:3b0e:99ad:b595:81a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb895f7bc1sm225452385e9.3.2026.11.26.01.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 01:13:42 -0800 (PST)
Message-ID: <1b8e3713-f527-43ea-bac2-8a9e088655f5@canonical.com>
Date: Thu, 26 Nov 2026 10:13:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 0/2] efi: gbl: Introduce Android GBL protocol
 definitions
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ji Luo <ji.luo@nxp.com>, Ram Muthiah <rammuthiah@google.com>,
 u-boot@lists.u-boot-project.org
References: <20261124211914.3088229-1-dimorinny@google.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20261124211914.3088229-1-dimorinny@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 22:19, Dmitrii Merkurev wrote:
> Android Generic Bootloader (GBL) [1] is a UEFI application from AOSP
> that handles the Android boot flow (A/B slots, AVB and fastboot). It
> runs on top of platform firmware and calls into it for board-specific
> operations via GBL UEFI protocols. EDK2 EmbeddedPkg already carries
> these headers (commit dfaa76349d4a, "EmbeddedPkg: Introduce GBL
> protocols").
> 
> This series adds the protocol definitions to U-Boot without
> implementations:
> 
> - Patch 1 adds the headers under include/efi_gbl/.
> - Patch 2 registers the GBL GUIDs for 'efidebug dh', '%pUs' and
>    'env print -e', adds a unit test, and adds documentation.
> 
> Protocol implementations depend heavily on board and SoC details, so
> this series only introduces the shared definitions. Board-specific or
> common implementations can build on them independently.
> 
> [1] https://source.android.com/docs/core/architecture/bootloader/generic-bootloader

Hello Dmitrii,

Please, provide the location of the protocol specification so we have a 
reference point for checking your submission. The link above does not 
provide it.

Best regards

Heinrich

> 
> Dmitrii Merkurev (2):
>    efi: gbl: Add Android GBL EFI protocol definitions
>    efi: gbl: Add GBL GUID names and protocol documentation
> 
>   MAINTAINERS                          |   7 ++
>   doc/android/index.rst                |   3 +
>   doc/develop/uefi/gbl.rst             |  97 +++++++++++++++
>   doc/develop/uefi/index.rst           |   1 +
>   include/efi_gbl/avb.h                | 172 +++++++++++++++++++++++++++
>   include/efi_gbl/avf.h                |  41 +++++++
>   include/efi_gbl/boot_control.h       | 104 ++++++++++++++++
>   include/efi_gbl/boot_memory.h        |  62 ++++++++++
>   include/efi_gbl/common.h             |  57 +++++++++
>   include/efi_gbl/debug.h              |  44 +++++++
>   include/efi_gbl/fastboot.h           |  88 ++++++++++++++
>   include/efi_gbl/fastboot_transport.h |  56 +++++++++
>   include/efi_gbl/os_configuration.h   | 103 ++++++++++++++++
>   lib/uuid.c                           |  47 ++++++++
>   test/lib/uuid.c                      | 122 +++++++++++++++++++
>   15 files changed, 1004 insertions(+)
>   create mode 100644 doc/develop/uefi/gbl.rst
>   create mode 100644 include/efi_gbl/avb.h
>   create mode 100644 include/efi_gbl/avf.h
>   create mode 100644 include/efi_gbl/boot_control.h
>   create mode 100644 include/efi_gbl/boot_memory.h
>   create mode 100644 include/efi_gbl/common.h
>   create mode 100644 include/efi_gbl/debug.h
>   create mode 100644 include/efi_gbl/fastboot.h
>   create mode 100644 include/efi_gbl/fastboot_transport.h
>   create mode 100644 include/efi_gbl/os_configuration.h
> 
> 
> base-commit: b7ed8d19d83d08d34b24b15c3dced7fd6c284939

