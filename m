Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137B606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IPWwFx5U;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dqoirRRV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35AE280D7D;
	Tue, 17 Nov 2026 09:24:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifJ6Fkiozf7O; Tue, 17 Nov 2026 09:23:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 391E480D64
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794907439;
	b=jKPSDaFKvhyBTYVFd52T9BvkeqLOrkHToiHzGhHnzNQBSdizg6VV1dgs7hP1HXjesFfo
	 dzv33ybind/b8qGXka5dlnuwEQOD85SQ3u6cp9iNx96UCvTiEQ9ltEG3jBtuhSJNMYhX/
	 gqGxvqYTbsdb0vXLic4qCqrmncYrxU4Y/r+bWY7O7FWObnCV7pDUOJcMDZ3pUwbCcDxQS
	 VAo0gwDX5koGyPguvElC8OHP7/04OT91JhwKlxnlpG+5DaL5ZZzojG357CXYiDVKj7jcv
	 fuj+V7AJ4dxZZCfPkXh+swGC7zljUjii11oyOSZokx58piC2PByMgPmzw6RNfevPV4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794907439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uQzfbdSfk7EsDQmg8cCz10gCU+CQRlFlQHEl6dFziHk=;
	b=Hw5iUge850WcCd8HFveybubEQR4l11bifwL6WgMAUCKyOuZ40Pi6na8zWWrUoPFjPy1a
	 iLWBmrZ+28w2WXM25iWV7dK2ZzFM0rlcWY5xjLhopbpcrxKaCQKQurKjpCOKLYYPo7YYL
	 Z74nY6zmntmA+KpazNkx6pVH+Z1tTP1L5TBej8PFpxSjQSwrttUnAuEmFg+XBw5XkhVz/
	 7sulMSoTg1A5bnvwUc8ckuJ+CtZ3GxHBotXPXp/VZRh+yBGCkrQK/gK3SIT0bZccJ8xOI
	 z/xho7xn8SCc4wVoXE+6De/byAaMdmmIC6B/OqdW7e0nlwvA0hcp//SA4a3+ZxE8IMg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=dqoirRRV;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794907439;
	bh=uQzfbdSfk7EsDQmg8cCz10gCU+CQRlFlQHEl6dFziHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IPWwFx5U31Ilf1qrg7l+LTJkM86QQoFAPBYStwXZT+XOaanHA2VrEL7zbG9t9zdZS
	 QC219cWSdlbfQVCyhRST1drjH0QZWqg/hsruV/aLmLancIpzuS+LK3NV6kn3rQx8Qo
	 mEQ119c+JX+m+ydHz8dVzIuNuEdZkQmV5Cvxl4FJ2tpIkZY0mHYcvI+Wq14hVxXZDM
	 IT8JLpT89SFmhZ1fqDVFwQpgvT8SmdQgI4XwZy44b8IIVgCUQ0g6nvFwg56fBSINPJ
	 lyRmmE3o6zqcFB7s0QNphxZUaCMlE8K0UGCu+xe3AB6UV4RlZg05026UswyfKc9jOI
	 WNpKBojfm02Pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 391E480D64;
	Tue, 17 Nov 2026 09:23:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 05E00A0E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E2B7780D64
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 86oLuvO98aA9 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 09:23:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA94280D5E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=jpanis@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=dqoirRRV
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA94280D5E
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 09:23:56 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1791761f8f.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 01:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794907434; x=1795512234;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uQzfbdSfk7EsDQmg8cCz10gCU+CQRlFlQHEl6dFziHk=;
 b=dqoirRRVqpmfv4VxnO49VdxnORwWcDZUVPUQkawmDsKk397YNpOwGYcKBwsvRntxDC
 Y2bn5ryBllRfAxQrPaUgjeQyObENPM54teM9sb5Su4U6ERFq0685S6Y/x/SBa/qQds3S
 tRnzwuzZNThNMzn0BLINEksVGz8VPzsTp0rFg2SG5IWtzkOmCNwlZU40kv6K7i93Z/1I
 NtoM52t1TlHN0jkCdX0PNt+od2tP2O7/TlVF8XOxEhuUT3ioGpfiOhb1DBAwzD2rnJHV
 jMM0VTmE2aZEA9ppfjL1tpwoRiOqSUwcKr2DRVowPRWgKwXfMXmleEYiT2dDiXfgztnp
 CHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794907434; x=1795512234;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uQzfbdSfk7EsDQmg8cCz10gCU+CQRlFlQHEl6dFziHk=;
 b=0GosYya/LthCgbuk7qimrqw2y902m2Q6/OTVHLTyt6WoDTL6Dqbi7Uu8LVDPAzuDyM
 et06ftI1mygYcV+2Q3AzN0azSYpwarghagf4Bbf8lBaHx+pIaBqFar/mJ7yclHjsPoj6
 zTjWwmQoxntFGybolX4C6PxcCkPdRvS4+duxqrITysGn8kLXaD9Yb2FEadQdAV91M/er
 Z/iSvR5d6DSQRAw6jDxMsUgi4hgdCgv3Hm9c5VqR3U4AeXkXWU95W4/XVjKcEAXYYTi3
 uCBH/EzdzRD66y5gSBlappfzb7+SwUUw71xAMWz/nXq2nfDPc2RJoHDF3i7PNmi3RSr3
 kmsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGaDXehdNj0geX/KbsJn6yrfbef7kJ6fpm3A8TzT5DDlM1Jo6kK7Xcp66ckGsVHy5rj7CrWHdI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/qaJ9d+BfZyjhLA7wN45VaA03lHpn/UEOMiU0XYa6ITnQnLxMf
 BH9G6aMjI7CcxjhKgwnn+gzMJghMG+jwuKeIEVrZKiLwpE37Q4ym1bE7vnxdoIUdOiU=
X-Gm-Gg: AZFdTZfwqG/Leew7pfnUmpokys4Qd84x/t/uDN43vyNyQJVAguXHrrNeX2s6StIZzVK
 iEs9XiSevvEDWN/TlbUtY/ScL+Wn+tJjGFIyp1ytWl2VgcbCHLwA7ctUz6MqbPWTVbATzgc+yrY
 PQwc1QaTJpTr/nXvk/Rv5dY/VS7CgfMcR/+BtJ++wz7ZuwWRenDRTqD1Og7dFYgNpjgNOiWiLW2
 d1NSZfDanU+2cg+2Q/QvHJclGRFRyFoIDXgAdU3Dem0Jv+pv2ZCEUKqXHJEmNh7zMquA1M214An
 edjp0X16ZLmIM8VX91Njh1CBFABBWyFZWm14sfNx95yoFoJHyDLI9C4nkSnWBP1Z7GBQs4y+pNI
 SxNl1k8UcE1Uj6sxz9fNk6YXFvjhBuCqfjNgYZmPANTh33/NpZAhqM5oj2du57dmFlalwp9Yv3O
 gbHIw3+Bs7Zf+uSacBS9lB2BYd70i18IpaKXiPx0gHWGeKA2kkZER0NmuzqDvUbO/dzbn1bEosT
 J9mv1fJia3iucmX1lZoLm6ZAecSK8iF8ERAPs5WHOtucACNrsljfEtMOBiDoaNzawCdaxlZ/MAC
 /7hXdyejCFFlzC6K62vB8LZ63FAwM5SjltFkB8C0WDcpCSJkmu6o5Yp8/ILhU+aCxz70UVL3ykn
 27d1q/abG7RqLOv51wBM+1cL9c4KO5k1oVqLDN4w9w+DjK9zIFrQAPBWbrb2+
X-Received: by 2002:a5d:5d87:0:b0:48e:5db7:fd6c with SMTP id
 ffacd0b85a97d-49c6e68da25mr31953956f8f.4.1794907434437; 
 Tue, 17 Nov 2026 01:23:54 -0800 (PST)
Received: from ?IPV6:2a02:842a:9e22:101:c355:6f69:9c0c:9308?
 (2a02-842a-9e22-0101-c355-6f69-9c0c-9308.rev.sfr.net.
 [2a02:842a:9e22:101:c355:6f69:9c0c:9308])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6451sm28589048f8f.45.2026.11.17.01.23.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 01:23:53 -0800 (PST)
Message-ID: <d8cc5a71-8293-4efd-bec8-900c8aa8ee56@baylibre.com>
Date: Tue, 17 Nov 2026 10:23:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm: dts: am43xx: Switch to OF_UPSTREAM
To: Judith Mendez <jm@ti.com>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, "Andrew F. Davis" <afd@ti.com>,
 Nikita Kiryanov <nikita@compulab.co.il>, Peng Fan <peng.fan@nxp.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 "Francis, Sebin" <sebin.francis@ti.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
 <1921fbd4-94f4-45d0-b708-d327fe6631f0@ti.com>
Content-Language: en-US
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <1921fbd4-94f4-45d0-b708-d327fe6631f0@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Judith,

On 11/17/26 00:28, Judith Mendez wrote:
> Hi Markus, Julien,
>
> On 11/4/26 3:47 AM, Markus Schneider-Pargmann (TI) wrote:
>> Hi,
>>
>> this series does the final changes to switch on OF_UPSTREAM on am43xx.
>> Mainly it adds some -u-boot.dtsi files to define tick-timer and other
>> necessary pieces. It changes the defconfigs and removes the old
>> devicetrees.
>>
>> This series does not have any dependencies that are not merged.
>>
>> It was tested on am437x industrial EVM with mmc. Help testing is
>> appreciated.
>
>
> I was able to test SD boot on am437 EVM and AM437 SK boards and I see
> the following:
>
>
> EVM: https://gist.github.com/jmenti/9c494e63186ad0ddc87aacc974f47336
> SK: https://gist.github.com/jmenti/a5d5ca0804f6c0f94e640d5fe0b76030
>
> With signature:
>
> Retrieving file: /extlinux/../am437x-gp-evm.dtb
> Card did not respond to voltage select! : -110
> Cannot persist EFI variables without system partition
> Booting <NULL>
>
> and it pauses boot here for a while.
>
> Is this expected or are we missing some configuration for SD card boot?
>
> Figured id ask before testing uart +  nfs and am437 IDK board.
>
> ~ Judith

Thank you for testing on these boards.

The error is not expected. I do not observe this on IDK.

Looks like the second controller (mmc3) was disabled in the old local EVM DT :
```
&mmc3 {
     /* disable MMC3 as SDIO is not supported in U-Boot */
     status = "disabled";
     [...]
```
The old SK DT never enabled mmc3 at all.

In this v2 series, upstream DT sets status = "okay" for mmc3 in both `am437x-gp-evm.dts:870`
and `am437x-sk-evm.dts:690`.

Do you observe the same issue if you disable mmc3 instead ? You can add these lines
to `arch/arm/dts/am437x-gp-evm-u-boot.dtsi` and `arch/arm/dts/am437x-sk-evm-u-boot.dtsi` :
```
&mmc3 {
         /* SDIO WiFi module, not supported in U-Boot */
         status = "disabled";
};
```

Julien

