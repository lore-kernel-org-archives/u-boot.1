Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE86606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J5zlWsG2;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ek6vEQ9F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1DD1606FA;
	Wed,  4 Nov 2026 09:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p1hIpTKkXIgO; Wed,  4 Nov 2026 09:17:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E1CE6074A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793783823;
	b=DP4SGFw5aKll4t0XFZ+Ap+mFtTYbLCirTRDUPYul+AGPaynL0SCqa4U6KeediBBHeuKm
	 SeQAxTzOklAay3DaCY2BW8u0/7m25+0LkVZCkm/sjWrKawtBecYxCgachyciQDLMzHxXH
	 VluOj5oRwF0Fmaob7y9Jjn7V0YqgvjH7wWXt7x0XFTXRXJmOIhB7s92QrlqatSbM7Ja9d
	 W8Vsdk0x6iQ5p/my+mbz3/get2fy+I1du7Moxj8Kbn28Nrfm0JOp64+BjFXwlbd20Wom2
	 ZtGKd7ZTK8+JeGOROf+ihkK8YtvVbdFlly29OPkg/bpXBQmj88rJdFYM+qSG1EeDjMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793783823;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=udf5eDqu5dl50R3sNLYH3GbkSzbw7p0jTPUUBpi1v9A=;
	b=VXjwgtObekc/EU2GwhAmvRty1bkNqMb752EaUWXGfPlT4v0k4xi4MOZm1FBym7Ym+jFk
	 +QXGsiulqVDcGb/2OAesa/5IDgFSxX6c5C30weFtuf8SBXPw30KM5fHOq/rdaF4m+Tcky
	 AOVGEoawojzcsmRv3sBFSTrSV+zXaXmlz4S8kcQNpYMIi+pPZhWiWak5e/vfSDY6VGwbb
	 HVNS3VYMw3vq+eRe4h+7qdWFtALXzIhdp3hTnlBV98Nc7RRuy6rrxRPwi5Ptn4OdZYnPd
	 Hdx2WAlG6rdzbe3eqTi4z8bFeReEL/f0NA/cFSaEgf8/w+oWaots1u5ay6E6B1mxW9g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Ek6vEQ9F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793783823;
	bh=udf5eDqu5dl50R3sNLYH3GbkSzbw7p0jTPUUBpi1v9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J5zlWsG2EncBJOX8uxIsOmVeK/2PCLC8GI5Pr3BE/K7A7W4WPDMINXHmPp2rxBfFO
	 H+0Q97xOvqR+Dxvi0syYgOCgfd+p/KAK4hJ4KMQTQtpJK0T+iIblfhv6V1+4inqFlP
	 6tBpP+OVr+RBvnNX+1A90O7e9fyfvJ1FN42gMXYpGvl3jBVteUuix82RWCyYeqbJX2
	 XytMnKKGPVjFcqZWTbQqGr41aCVxkDsQ/VpBmYd+DYkIuKqrgAkQl7d/swAwP6JeDi
	 6kfDmFvb0mVxJHi/Bo+Y/nNT6HpUFg/KlvEeKo0vkXsNQVHZSHqpn9vN/qX/Fh1D7R
	 lEQltBkm9EJRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E1CE6074A;
	Wed,  4 Nov 2026 09:17:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 66F19A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6433E6074A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PSbsu8i094kY for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 06607606FA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793783820;
 b=YkFn/OdCnVgSRjHZHYkVt3SGoJQs8C3ObEL+557KWeDXL4FLn3Cak0GwSYBG9Dwb/GHN
 RicL8nqpgKYpvUwPOQOK0pxR21i1WVRl3W1U4LMWpItOehCr7p4qQ+SzVFCv+HiK40REy
 wljJNBSrHeJz/YjYm3eZ02WJ+xvwjmGscyhjdrnw0iSdI6FyzIBZqBYvs2rTqW07gJOT6
 nSQ5TWa8ACYFdUtOYBmXzVve/hnxD5Jmq/OHOcIpLBe7Tgja4leMp/fD1DY3qZ24A/I9D
 odpf275H1FMp36YhA+dVxGmt/thmukbUbc4YjFCVgAcVYHv4UDaeQ7XKjNaZELUMaAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793783820;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=udf5eDqu5dl50R3sNLYH3GbkSzbw7p0jTPUUBpi1v9A=;
 b=Bid4URrjsjnavs+8Y/VTHJbBd4oG77/sOakaKjarez0ElAgzF+6dtDVo3JbXwqFl3wBD
 S2l4xy6gmmsxxJGnKR6LICDZEIhWlIEAumttXZqXPrzGYkDOEBLZgsqQZ1wmC/xSv/vmS
 n8v44uzx/HC+F+aN5zmvpeL2NtTDHDzLN32LI/YpXfYxqF3uxOnvy4uktH1eAym0++Zb2
 gUlSJB1E/Ad8zRSmuHV898v8BQTtNWZlITHbxuogaWMEVHKvZv5ACAcOI1bqLiALTvthu
 SyQxz75NMjvjWK0o7Ke2DOCq4dJDJUvK+j4sHtU+9oX68LGJ5xpQkZHaRnXePhOOc9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Ek6vEQ9F; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Ek6vEQ9F
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06607606FA
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:16:58 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso228867f8f.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793783816; x=1794388616;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=udf5eDqu5dl50R3sNLYH3GbkSzbw7p0jTPUUBpi1v9A=;
 b=Ek6vEQ9F2s6Ee5LRvK9O/cV4D60C1fS/Q53BM7z4fAE+Y4BOIirdr6zFlyMi8GPJ+v
 keI8cA7Gu/PnPctY/Grzp3/fWPT1A9+LdGiEs/tWkGLjcQzq72nDy8BcUesYK+lyJmkt
 0oKkgleUZfum9/uSKTQ1OnUxPL78TQQMgyqoDVJ+B1QFamgSd5igLwntz4GIqgHJSUQ6
 GyYVmdD3AIOXmF8kJyxEJ8c7r+99oVGV+yIlQg9N7jxSPUNthSXLaaDukylU47OdYlmb
 f/jfDQlKnW4Hp109VTV4WnScfEVyvKrU2j1Wst02k5aNfuXmlZsUiYSbbhHOuY5qJa7Z
 i0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793783816; x=1794388616;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=udf5eDqu5dl50R3sNLYH3GbkSzbw7p0jTPUUBpi1v9A=;
 b=L/xW/ucVIvevjF6pbMVXzvNv9sjAP0sIFyMnwTs+PkS4CifwLyHtMb8ZSZSQrL8quK
 noRgFEcsff1cxvJasNHAqBUAWimaneGZcvyRR8goOz3hE9FFciCAvL0HA8hF3WE4pcTV
 AQbrkAsRUXK6dUwtN241CiPuVNRzWm+zxjPgsizKBPjz0bWk3j4N+UtrnXPJeTXq4JHL
 feLT5xbV7HAZmMMinzrR06lG9tinAlYBQDYtjHQ6DgS7cmJVCmwsqDkSaaicYbDpq583
 wQWt6/5V3AjLDiCfCaj7grjDn4SVWF+6KNhaqPvOaR0WuDd8AAP9Fka6dP+nYKUWyugh
 aLnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx33gu16PwDBGinZ9ouq1rSh6rtmYktPe8r3aQQfZsl/OQ4gZDkC33zAsTq59zQbdKddyRzEOQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+rxQh9mfKokKqg4owgvD0HqgBHNJrYxWg/lD7B5+dXOeJwSdw5
 HMrY2CaOoY6mJYUIUzXb4P6RBoN5dJxj1is1UIPpAIheY/au+8htOsnUrhdODbCwVMY=
X-Gm-Gg: AYBFou3gzGFDc3LWQ9QsXK/oll7FsiFpeWjtQXs2ioawMESABN/fwYPKHQ2qnmnqPRF
 8EyPwHSPRf6LX9U04aEU493iJw3jDDz9XpdBrbRnoiz1z7piLHuApqUaG7sSXOSBUZxU76jT7SO
 EAQlTQTlTs4mogs3/o747c0TmNZIxBdGReUK/HxEb8VvicXQgmR10EALWGu0WIhDl4qYdzoExNA
 /Wsv748GirPo0+Nb3x1xlpJad/obxUf1nGuNZ4pRx8oP5V9i5u5/U2TcLbx/X/eDEwC5YaOY6u+
 8+kkP0DVNDuDj19m8ReV6ouZ7pm5pg7vTqOMzYJE760FZHZ6SleHLQ1v5u/54m0L3xHcAs2u5Kg
 7uPm1pcT22p4tym6QsKE+1atJcYZwpx2a/GBmhsF2eU7LSgmPNEPu+6OeQfXX+Vm2OSX2rAjVpR
 VEYsDj1gk2cxr7BJN6SH2XpckzAxNAXq1AJfqRCL5h7ahuDDLZVeiWlEcW2x3fDj+JJRY1xJtl7
 7cBFYhnbLLXTrEHzG+uiKKJusvwBbbvy9pMEv/A/DQd4SWEadQOYwBTu3mP70aaL0UoNyYdwjA+
 vo74wbfHS4zSffyhtmEP/Zcv+bg+SqdYompwpK9vqpHECIoSJ0Pgn7+n
X-Received: by 2002:a05:6000:186c:b0:48e:7a19:7aad with SMTP id
 ffacd0b85a97d-48e7a197e64mr28723569f8f.6.1793783816233; 
 Wed, 04 Nov 2026 01:16:56 -0800 (PST)
Received: from [192.168.1.62] (140.30.66.37.rev.sfr.net. [37.66.30.140])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d71dsm2751596f8f.36.2026.11.04.01.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 01:16:55 -0800 (PST)
Message-ID: <25dcdf57-84a8-4851-bc25-5334bb5d96f7@baylibre.com>
Date: Wed, 4 Nov 2026 10:16:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: rcar-gen5: Enable env erase on the Ironhide
 Cortex-A U-Boot
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Aristo Chen <aristo.chen@canonical.com>
References: <20261026-clegoffic-env-flash-erase-v1-0-18777abd1bde@baylibre.com>
 <20261026-clegoffic-env-flash-erase-v1-3-18777abd1bde@baylibre.com>
 <976abcd3-f947-4273-ac2a-97f7eb10f367@mailbox.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Autocrypt: addr=clegoffic@baylibre.com; keydata=
 xjMEafx9bxYJKwYBBAHaRw8BAQdAtc85GIwDXLz0rh9thWXC80Lji0otVDVncXT4qaS4j1fN
 K0Nsw6ltZW50IExlIEdvZmZpYyA8Y2xlZ29mZmljQGJheWxpYnJlLmNvbT7ClgQTFgoAPhYh
 BJjMiHuM4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEH6EW4KtCh6Tt+sA/jVC35rY1npFlOy7YnncTdrID8Qf855JA78IzXgvzpGp
 AP9FkuuT80m66PP3DvgYX9kVnG17mSDKO0+v2W18v6ZgCM44BGn8fW8SCisGAQQBl1UBBQEB
 B0DMwF4u//aQyzsFlO8rPJ/cqsAuPH80IeIA3HOEo5mlVgMBCAfCfgQYFgoAJhYhBJjMiHuM
 4ZUwFqUPr36EW4KtCh6TBQJp/H1vAhsMBQkJZgGAAAoJEH6EW4KtCh6TdSgBAMDS0MiWCivt
 LjzZc9bs+P/xdXywUjDKq3lpQGJ6vZ0GAP9vI6DnN7vwVK6jt6/+0aBGkog5Ura9+WwRFEdM
 vLfPDQ==
In-Reply-To: <976abcd3-f947-4273-ac2a-97f7eb10f367@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 11/4/26 6:08 AM, Marek Vasut wrote:
> On 10/26/26 3:41 PM, Clément Le Goffic wrote:
>> Enable CONFIG_CMD_ERASEENV so that env erase drops the environment saved
>> in the eMMC boot partition.
>>
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
>> ---
>>   configs/r8a78000_ironhide_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/r8a78000_ironhide_defconfig b/configs/r8a78000_ironhide_defconfig
>> index 527d338a663a..bb11166092e1 100644
>> --- a/configs/r8a78000_ironhide_defconfig
>> +++ b/configs/r8a78000_ironhide_defconfig
>> @@ -16,6 +16,7 @@ CONFIG_CLK_COMPOSITE_CCF=y
>>   CONFIG_CLK_SCMI=y
>>   CONFIG_CMD_CLK=y
>>   CONFIG_CMD_ARMFFA=y
>> +CONFIG_CMD_ERASEENV=y
>>   CONFIG_CMD_MEMTEST=y
>>   CONFIG_CMD_SCMI=y
>>   CONFIG_CMD_UFS=y
> This should be enabled in configs/renesas_rcar.config once , not for every board separately, that only leads to inconsistency.

Ack

Best regards,
Clément
