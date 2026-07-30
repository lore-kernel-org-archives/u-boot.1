Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB86C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BE5380FA9;
	Thu, 30 Jul 2026 13:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j1-ymRhdim59; Thu, 30 Jul 2026 13:30:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9622B80F2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418215;
	bh=P3yBuFvXOrASJ/lDjtf2B+t6JtbKioIKUwBYLA8of+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OdlyWa+DKaeLxyvzVjm63y1Lt6aOaHQr1oY68uNFznBVJKTpMMjEw6Bu0xNflMxKM
	 t8g6QRh/zt55jIvZP1sTrgvWWVXLep3X6eVwSNZmOAYrkV1nb4OvEoY4o5XOrS0tfn
	 FLvZ441okNpqA3VXL+PsNLzWfK9U2pte650BiC80nuzlFCwUdrfzS9t/rhmll87Cvr
	 KXZqNZvRTCY6em0nIVQY/tXoYWHGcrC15yaEvpP2T1kzgPg4ZR5oB65KmE5RMhPSZB
	 qDPmVF45k9K/CXJNkoEBMtmDaTKHQ3DmJZ2cGz6Bu9el/o3UFXt/j+5sgPSDeXeQui
	 DBVvVYm+DyQ7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9622B80F2C;
	Thu, 30 Jul 2026 13:30:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 622E627C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5438F40899
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:16:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WdPXqNF0qI6z for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 11:16:55 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DB5174094C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB5174094C
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB5174094C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:16:54 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so18196025e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 04:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785410213; x=1786015013;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P3yBuFvXOrASJ/lDjtf2B+t6JtbKioIKUwBYLA8of+c=;
 b=nGXPYczKDKxXv5fCKaqfBXjTSfqQHXoea7EoASZLUeF9RSUW0GekjPowgpT+AmsfsH
 KI8M1xuoX9P09hgoNN/iUYOP6emPeouqwN04DqyV6v4Gt4U5dHfWlzzg/ChD8DuG3cMX
 GZkguN1on92qvoYaAXorHQgSyvIseMApNQoCqABQewZL21aWXPQ3y2nqtS0Gaty0aKkJ
 AqG8djk9r/l9ip3gfytfw4/tkUF8vLWC8cFB7fq4ytIiJ5BKFEXn+rZiWFBPrEo91VKR
 1h+gsmgrbFR5ZWcmOkD74p2hdgUT/0NVjJA2+A4aE96UPXz62QjnrGVKy1CJSWw4Sh7K
 N4Ow==
X-Gm-Message-State: AOJu0YxtQVfpVXySkSfxns5cUGvFNLfVGhgSYVHnqKTk0HGASmfPTfi5
 IIxXt4rCQX3apEey6Dq6TjKWK/Zs+/d5UUlC1Pvk3niG4alnRS4IJTsWpFGiF2CgnB4gY4sIhsH
 /ObhE4XE=
X-Gm-Gg: AR+sD11kcQLcTf7FNyXaCq0DsS4TzckMa34gcwJtJd4bzbuTuI5rx3b2kgWw0PbyP5B
 3AOrY4JDfMXJW7MkEEVj+rkaou20BEfr1eFcJCvb5ovD1E2eHWn6HIH7EVGbLYKbpzj3vNSobmz
 HYNMeucXXYD3K9KgKWtEFbyOGsO5XNdgsfOzJpdGyCWRpjTEobr06e/RRdnQP3WHKG1077EumLt
 4amhaN2qnDYiPabdu+GY3zy8+ma3iM+eKA0u4+OJhD6oEplZV3n5dJx/4RGGYiX455B/iXKLDU6
 Wi37Azl9Ie8iLkySLVyNuj19zrlUw20mt3+khYbVz50e1fE2ocVHCPvjHxqMzCO88sFTc9ouI/s
 0fV1PiSnK3rmaRpvmHSr5yfPjGvjf0CAG6M/HSGaS1H5t1kKfTXEzzMTOjceNC+IH0MLptHJOsg
 qdbIrCwNHfVidG3I0XUtJ601GpNgaGfwo7sOm2cW8ocsGBaYWmn1xDuPrfPWCxRBMzO//i0N4Ks
 gN6z0eLgIlW3pFVAwl1DLFm348/z/zsZ0T89hsUQ6JWJvSiJzTb5+AGchzPN2913F5Xn5IFMZlw
 9xh8CB9OfNpLZiVL/vZOcdms2cvLB+CsuG1dj2n9YdvKOw==
X-Received: by 2002:a05:600c:1386:b0:496:df96:ea8 with SMTP id
 5b1f17b1804b1-49800e816c9mr25317165e9.17.1785410212456; 
 Thu, 30 Jul 2026 04:16:52 -0700 (PDT)
Received: from ?IPV6:2003:ff:f03:8f00:4cb1:53a4:7b38:3d18?
 (p200300ff0f038f004cb153a47b383d18.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:4cb1:53a4:7b38:3d18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e3d7fsm5500854f8f.9.2026.07.30.04.16.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 04:16:52 -0700 (PDT)
Message-ID: <eb6d2f5b-33f8-4d47-b27b-0caf18edf55c@byteray.co.uk>
Date: Thu, 30 Jul 2026 13:16:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] tpm: bounds-check the device-reported response
 length
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Miquel Raynal <miquel.raynal@bootlin.com>,
 Reinhard Pfau <pfau@gdsys.de>, Tom Rini <trini@konsulko.com>,
 Argus <argus@byteray.co.uk>
References: <20260729-tpm-trunc-resp-v4-0-5dd1a634ea4d@byteray.co.uk>
 <20260729-tpm-trunc-resp-v4-1-5dd1a634ea4d@byteray.co.uk>
 <CAC_iWj+m642ax11mjm=GDLO5v1RZqVxcoSXpJD0Oyy0HPvONzA@mail.gmail.com>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <CAC_iWj+m642ax11mjm=GDLO5v1RZqVxcoSXpJD0Oyy0HPvONzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 30 Jul 2026 13:30:14 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785410213; x=1786015013;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P3yBuFvXOrASJ/lDjtf2B+t6JtbKioIKUwBYLA8of+c=;
 b=Ww34lZ0vq8KEKr8yIpZWtjuiBboaoiJbuqIhI/bs2R8PUk0nell7BCQ8i3PVBt2h0J
 UYK/bXbiyDrvWg0BPd6qjmKowUhSSfBPK3j/Z17UtynZ72NLA1p4AKIipb2UCHFOEfaD
 9rh7kUqtYBWhMVrgIjyXkwSoAnu9fBK8W1LtdreuWcAn4jdMg8NDzvs9kEB53YFsjrYa
 qNw9jcqWDSciMdRa6g/A8hiQQBi9wIECJYwATSN0/GaEXgAe1JCbxjSK+bt3gHm3VUUU
 g7iIOcCojapkjuakroBED2F8tWZwmm1cBUWC9Sh0I/v0IDUl1RrzeZ3z92FrS9CwoMo/
 FUhA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Ww34lZ0v
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Ilias,

On 30.07.26 10:36, Ilias Apalodimas wrote:
> Do you know if loading the key includes the header in the response?

It does. The LoadKey2 reply is the usual 10-byte header (tag + size +
rc), then the 4-byte key handle at TPM_RESPONSE_HEADER_LENGTH, then the
41-byte auth trailer, so the real minimum is 55. I'll fix it in the next 
iteration.


Thanks,
Shah

