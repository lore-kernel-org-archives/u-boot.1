Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02CC606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c6fVuWk0;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=YI/lmmKD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57DC3810C3;
	Fri, 30 Oct 2026 06:54:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QWsSWDMC4wqx; Fri, 30 Oct 2026 06:54:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B12BD81095
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793343293;
	b=faJnzRFB8mh5kuTC6yWPLBrvZeZDwBiqyBmMnHh0nSAA0kEgDQp9ROrISVeaQDQ5UY6q
	 q3v0OvnBr/IKGYBX/jsjjKb6EllL9qSwy6RLPVi/VBJoKCTwAnvAqjXKTrid5m3/wuZNL
	 /IAHjPa7bK0xfXydwgK1lixaG+av/b0mauZ4HiH2macikOhsDarMsF95FRheSQRHL+xUT
	 ooo6RdrCKleNbYHs9HeWMbqIuM43ePIrqpq8Q9+JcsBKF/NQVnxQnbx96FtoKPjbbZSzf
	 zJPdldBrzi1CA6aNy5St7o5kOpPUm7yYAtDUTomN9Sz3v7a5DbRN2aZuT+7v5wi8y4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793343293;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2sjljJCnKuXTQ/f35V4LX9YnHtpo+DAmV2igBElM7lw=;
	b=mgLl9pAL7scErg1CgI8TpqlwvpXIFfkiJvVlej2guIgL3yQoLLcWUY+evQQujiKVCNW8
	 PBG3mwfTq0T1HTyoLaWqWmaLiQfMQQCRIF/ioTDaUrkO8Pv9qr+nDIQVdx63t0ztzzw1+
	 jj/injdsIHmpNRBFA7tC4NYji8MMclVE14sB0M7lNcvUuSIESKihIQm1jSOR/uBx4MLuu
	 Cgvel+WfUfo+ErUpV4q+eFkGQY7/osg1S0/QPSC57NRPa6yGbm2LbUFAT6XPHFiL7UG87
	 C9zMcsD0y07ESzpAdfstFeVSSJo/IilK2qUwPYUzuNaNNaqyjLjWvqUWwktIIi0K8jA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793343293;
	bh=2sjljJCnKuXTQ/f35V4LX9YnHtpo+DAmV2igBElM7lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c6fVuWk0fvBzbAkTwRD7ZYhKeoMw7nzSOFZ4ei2/3+oT2CuPFrBDkfAHlms44g2nS
	 hKzwHkK1l9S48rSfysAi8Qm/Csk+lIRaRrHRzDtJ3dDlX5Ldvi1N7nbeaC0YPpzbbZ
	 gTQXjSR1M2XSjD3e/2cVGSNi+vSFk2AQZT5vRjo+WgWlrQo0LJ2Cdq7eTiqJGCbNtn
	 4MYjxBV1xzUzcPJAmQgZTd/F3GWnApdTyk1wd9pl2nhWT7mYbPptHuylZKC4seOMMc
	 3CYuynL8si+v7O3a3HkFNmRDeU0RhRd9rXwJI8EkWMOUbJ+ts+JgVrdaJdWJOeqzih
	 IidcbvqTINjzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B12BD81095;
	Fri, 30 Oct 2026 06:54:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CDE6D2C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB5A640AAF
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AbQjqhVI8Cmr for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 06:54:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1056240A8D
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793343289;
 b=O54TM6QxidAiQSIK2cT5ExeMIPXA5s0UE4+nAsIfrbO4u8IjPg++E+b1KQ8RUDAr2kEc
 QoOTYLwlchhaB3mDeMwDkw1UFG5mJXqRrqSeFZBJol9ydIOAd9MK+H0pup/B/SIpTpEcr
 LnIlD1J2BWZHGQ+EOQucdDgmXBBD2+kuR9hRli4hIYwuUcDmPt7+OWUFtu7g2n8lfZtv/
 JWhLMp2YahK8KHVBdjLorrYZEVGIKsRDMUpHAOWtwJCTF9bjbrFDgWw5t3lPBVp2fjCST
 w8wg3jly/Kyb9Zcs1OjDGbOKyJd61aNinFNLdISKNxGzYmNfgEnLmTJp5cp3CkohMLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793343289;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=2sjljJCnKuXTQ/f35V4LX9YnHtpo+DAmV2igBElM7lw=;
 b=JsNduucYeolksfMHd3TyJJRI8BAao6lM8VBBqBHFsA1LczRU2WSX4FXRW4iZF7uX0aQ5
 AAoUF/ZRxHGMPc3u/eNZdJ7nLqcCRH7mEmG6+I9WBUcvZc+8MSwYkC/Q8tbZAAFOb038t
 dE4gQCAReUkBHlsZQhKXj+cw6Vqc/BfNlumKayv7O+zjta4DqBm8zVkcA4c0vhmakrD8+
 VtkaDHAI73eELXgJA4tfC/g54aQr1msTq7v9Ki3ya0vQ8xE19x5058YWv1mkwaUClEa/1
 kizcxB1KJL4j6t54ZV/ePkccWRaV2yJcXlc/JRteAh88OTAXp89D2yHI5BQBi4neQWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="YI/lmmKD"; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=YI/lmmKD
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1056240A8D
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 06:54:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4AE9810BFA2; Fri, 30 Oct 2026 07:54:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793343282;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2sjljJCnKuXTQ/f35V4LX9YnHtpo+DAmV2igBElM7lw=;
 b=YI/lmmKDVz2qbFJxfTT/W4T7iZ5wVtjA9kCBUxwTb7tz6Rad3BkCR1Mp2h8j7or3GyfLEZ
 3B9LDAdS0ocD6rZzPPZ2KeqaVE9dwPUZO6970V98h6pTrBd3/B1KSy/iHuueUPOLlV1qG8
 MbAra2r+nJrg8KBN+OhRZzfolbEq/0vCVp107s4zrab9Ggqv9871C1TWMQ6MggKMjJykGY
 wfXUAVx3dUamqv4qUxekYo8EF3TasqmxOh5M4aQLTCtosfDArvlFUigZcHVtkAyWb1t+ZG
 HeBnGfHFQhCI6dWMo9PPOTe5ydKXIKLK/uGZJkg8jKVTUkMjWPod5fcszcI9Aw==
Message-ID: <f65083e2-9f74-49f5-b451-089b5af4f4e9@nabladev.com>
Date: Thu, 29 Oct 2026 16:02:44 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] usb: ehci-mx6: unconditionally run usb_oc_config()
To: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Mehmet Fide <mehmet.fide@gmail.com>
References: <cover.1793091394.git.nora.schiffer@ew.tq-group.com>
 <9a416f0664c8594c0af0573b5385dc4cef7e2dcf.1793091394.git.nora.schiffer@ew.tq-group.com>
 <523b0b3b-f260-41bf-8455-b58acca52b03@nabladev.com>
 <79648af2133070a0f6fd9273b7b5870c79fdf2b6.camel@ew.tq-group.com>
 <3748221b0fb1cb6d64e587829ad107a52b95a5b3.camel@ew.tq-group.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <3748221b0fb1cb6d64e587829ad107a52b95a5b3.camel@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/26 11:22 AM, Nora Schiffer wrote:
> On Wed, 2026-10-28 at 15:54 +0100, Nora Schiffer wrote:
>> On Tue, 2026-10-27 at 18:25 +0100, Marek Vasut wrote:
>>> On 10/27/26 10:39 AM, Nora Schiffer wrote:
>>>> On i.MX6/7, VBUS enable and OC polarity is configured in the usbmisc;
>>>> there is no PHY driver handling this. Always run usb_oc_config() when a
>>>> fsl,usbmisc exists.
>>> Would it make sense to add usbmisc PHY driver ?
>>
>> Having a separate driver would make sense, as the usbmisc is a separate OF node
>> with its own compatible. Thinking about this again, maybe not a PHY driver
>> however, but a UCLASS_MISC - on Linux usbmisc_imx is a (subsystem-less) platform
>> driver too and it doesn't really implement any features that would fit the PHY
>> subsystem.
> 
> Hmm, I'm unsure what do do about the !DM_USB code paths in ehci-mx6; I assume
> these exist for constrained SPLs that require USB support? Having a DM-based
> usbmisc_imx without DM_USB seems undesirable, but duplicating code between the
> existing and the new driver would make ehci-mx6 !DM_USB support even less
> maintainable.
Please try if we can do with DM_USB in SPL (I can run the patches 
through CI to validate nothing got broken) and if not, then we might 
need some crutch for the SPL.

Thank you!
