Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B54C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 12:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A530887BF;
	Mon, 29 Jul 2024 14:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=inbox.ru header.i=@inbox.ru header.b="fcY84zbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33734887B4; Mon, 29 Jul 2024 07:47:38 +0200 (CEST)
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [95.163.41.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BB8288602
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 07:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fido_max@inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
 s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
 :Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive:X-Cloud-Ids:Disposition-Notification-To;
 bh=JyKvhIJtpqsfND6e/xQzbK4HNRVh8U/V0miNzIf/yWU=; t=1722232055; x=1722322055; 
 b=fcY84zbApoPcg9dwVFU71q1LU/OGkS/DYbHhJnQTyUziWthSSeaNeUAypBXcPd6M2DvO+YsnL4i
 RDLAHSEeDGvCmFYGcvKRhY0UjfkGCaTseVOAwH3tJGyqmAJX6yqHP82Vq8QJToyh6AiIHE4RwqhCM
 4ql4cc0D5Nas2GVYN7ofZOjD5cJN7fQx+tPZ22aaGSDxNOzGdqzydXCeVIGyZxME39+dvdK5eL43M
 NRXm6ai5Rhkw/dHCPLZaaPOq0PwWbxPd1qm8Z2RB+d28F0jippa7nVJekO5nkJh5MgWbbj0FLmA2f
 eabXFVT1DEm0tTFf+yxatbahhI4bqSIQ433w==;
Received: by exim-smtp-868bf69f6c-jrksh with esmtpa (envelope-from
 <fido_max@inbox.ru>)
 id 1sYJEK-00000000JR4-3eL8; Mon, 29 Jul 2024 08:47:33 +0300
Message-ID: <049ecd76-8dc0-4506-9355-5f6e7ae94392@inbox.ru>
Date: Mon, 29 Jul 2024 08:47:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: define find_{first,next}_zero_bit in
 asm/bitops.h
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de, rick@andestech.com, ycliang@andestech.com,
 trini@konsulko.com
References: <20240726120721.150484-1-fido_max@inbox.ru>
 <CANV2PTMxAOrVDGrD-QJWJjdJ=+1NV-9SNcbBZTsfMuDhqiJR=Q@mail.gmail.com>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <CANV2PTMxAOrVDGrD-QJWJjdJ=+1NV-9SNcbBZTsfMuDhqiJR=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: exim-smtp-868bf69f6c-jrksh;
 auth=pass smtp.auth=fido_max@inbox.ru
 smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9000B6812E77BE1C6C95C4F1944E32E59211CC92C36EF20F3182A05F538085040953632B6C8AD599D3DE06ABAFEAF67050DFF2D642BC76527C91D94A15C134E917E11F6D7719F38BE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE705B093C0FC4B30B9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375A514678F9DF65078638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8DE3F998674553422A83D78C02541A7AB46F697E157280A5E20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C091DAD9F922AA71188941B15DA834481FA18204E546F3947CD23BF7408B3F9022F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063707A1F3761B83B09E389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FCF1175FABE1C0F9B6E2021AF6380DFAD18AA50765F7900637F09814068C508CC822CA9DD8327EE4930A3850AC1BE2E7356C9A9530EBF72002C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5F7D4B7270380899A5002B1117B3ED696B01E5E00B552E4FB957033528158102E823CB91A9FED034534781492E4B8EEADA3FB0D9844EF8EC5BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D3472E5ECC12A9739C1D2690D26E3280944151EB416270C2E200CF9D2CC4F532D34A8357A0A977FCAE31D7E09C32AA3244C3749C9B1B02F0D3377DD89D51EBB77426617FD882C79C6E0EA455F16B58544A2D06CB91D864A7BD257ADA2CBCE38F05762A0BE504FE5E636F1E3461735CEBA253FCF178C6DD14203
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojX2k8aL79D6UV+kTfBBUIKQ==
X-Mailru-Sender: 689FA8AB762F7393C6D0B12EA33CAA9B41AA34C7042309332DF6FE1A74364D27E7BBF71E5556281A90DE4A6105A3658D481B2AED7BCCC0A49AE3A01A4DD0D55C6C99E19F044156F45FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-Mailman-Approved-At: Mon, 29 Jul 2024 14:55:00 +0200
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

27.07.2024 13:35, E Shattow wrote:
> Is this a problem in Linux upstream? or specific to U-Boot, and is it
> a regression?
> 
> refrerence https://lore.kernel.org/u-boot/20240504183354.GL2568172@bill-the-cat/
> and reference https://lore.kernel.org/u-boot/BJXPR01MB0855813DD38EF86CCA6DD5C8E6E92@BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn/
> 

It is very similar. But it comes from

In file included from 
/home/maximus/git/yadro/ymp-build/u-boot/include/linux/usb/composite.h:26,
                  from 
/home/maximus/git/yadro/ymp-build/u-boot/include/g_dnl.h:12,
                  from 
/home/maximus/git/yadro/ymp-build/u-boot/cmd/fastboot.c:12:
/home/maximus/git/yadro/ymp-build/u-boot/include/linux/bitmap.h: In 
function ‘bitmap_find_next_zero_area’:
/home/maximus/git/yadro/ymp-build/u-boot/include/linux/bitmap.h:170:17: 
error: implicit declaration of function ‘find_next_zero_bit’; did you 
mean ‘find_next_bit’? [-Wimplicit-function-declaration]
   170 |         index = find_next_zero_bit(map, size, start);
       |                 ^~~~~~~~~~~~~~~~~~
       |                 find_next_bit

I've just tried v2024.07 and master.

I tried to drop #include <linux/bitmap.h> from composite.h, but it fails 
on usb gadget compilation:

   CC      drivers/usb/gadget/g_dnl.o
In file included from 
/home/maximus/git/yadro/ymp-build/u-boot/drivers/usb/gadget/g_dnl.c:24:
/home/maximus/git/yadro/ymp-build/u-boot/drivers/usb/gadget/composite.c: 
In function ‘reset_config’:
/home/maximus/git/yadro/ymp-build/u-boot/drivers/usb/gadget/composite.c:362:17: 
error: implicit declaration of function ‘bitmap_zero’ 
[-Wimplicit-function-declaration]
   362 |                 bitmap_zero(f->endpoints, 32);
       |                 ^~~~~~~~~~~




