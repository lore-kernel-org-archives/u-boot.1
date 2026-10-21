Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC06606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 06:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lM9TF21y;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=gRAktVXR
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB2566081D;
	Thu, 22 Oct 2026 06:49:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4C-YTiMtPBi; Thu, 22 Oct 2026 06:49:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1A9CF607C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792651793;
	b=ZylshyALI+sC0WSfsknvrgfGsjs/Wpq91DCQwDVDd+O8aNLCbCqMtGWEq4GzKpwHsmCU
	 BzmlH3ctG7B5z0POyExHWG0wYuMqOetXpRo37bExdQjj6wan9Jpi/wkwFIIiOFxPbxh66
	 0SJYweej+WGB/9yuPd2J2nFWYkTDgTR2mY56Wxv5rSWn3XRR5rCI8O/I5K/Enli9IeuuS
	 AT2oKiYrzFY3kdJNAGqexZ5DyZ9zH7UXygEvyl/zIi6BXFJNpey4zwMuv1o4vhKDhU2zx
	 p/4BrBMCJ0Zfw3gwNA1uvVbEoXbZPCTETEf6ovKP/ksknZgQnk93J/T2s8ls70Y7V8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792651793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EU5wQZL8JRp97zAjr6+JE3lhxrLUsCm+6WMe8XAx1+s=;
	b=Z4BtcPAxQuImuplTaFrhL2RuWnDsQ/OwgwVH/Z1YzWuV83+uSuWPXuOstGSqkweMvNmK
	 s2HFmIa59czneU7N9LZct0L0aE2HcxlGmTzVcTeefwefS+orfcSXk+kBt0DB2wRhr1hC/
	 pm8W4MvaxY278RZEtaDukL84EGJaq0BiJe1vwyBBMnEjgbty0XYHOD/D5nyOL7Lkmafa+
	 m3gRo/McTwVsEA5bnKgNY8eKDYyDfDUd3+9KRuxTf/Pt/RoDAzjUWVSrzmvr7BoGhT7df
	 MlLwhlbWaDwz/cQQ1+LGSvLeEesmxbRhfXcxvVYc22n4xFRrbzqbJ+oh4Cer9Q6QLAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792651793;
	bh=EU5wQZL8JRp97zAjr6+JE3lhxrLUsCm+6WMe8XAx1+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lM9TF21ysxqobmQwvrNnsu0hB/EgLTE7ZqDhtnon1C8COCD6a7CypJ79d1T7piAMe
	 d/Nv1m2GavCLhnOpAokvgD2YKMFw8XOvl+1TxlBPUazoDnpnxOebDCTw5OIuLAEi25
	 b8Ty99Q3ZzB67zoWaHIduNkVUr/xsvSE2a0Ft7FqqLd95EfarRdvBOjcm6wH8WVk21
	 ILTAwpnLZYNQbG57IO7VvtGP3s9/mDZh/ggNwLXnppi7FfqVckyziuIBVtUFNfmVS9
	 3dglK3fLCzRzyIhllOJ7AvXKf2XsgyqnKVM4uvTotkmLqDcAyEZ/P20LhTA2VdkxkZ
	 ThtEQ+hZjgpSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A9CF607C4;
	Thu, 22 Oct 2026 06:49:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C4F63C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 06:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61A7140800
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 06:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ms4pPDfIoyJn for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 06:49:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E6C1940801
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792651790;
 b=cZBDKy/+ZTi7Kt1AxBKSdkWbWihBqeWQcwDpk18iqmuqNR2IXAMWUSc+r4emKUR2I/Wk
 wTvSXi1WUMlf+op0Aydd9EgKmbP2rJkia1KmLv4cwEtzkPlSG94LhPFTN2ohYmFutvafq
 GSGxfnycSFtK8KMICUvuNshZ7gLXBrj7Qf7NeruC7/6odkoGsICtLJs4h7OndLE7C090c
 EdRlfT4BoJyz4JZI7CHMbj8P9IGckGf2O0o2uxsGIY4Jw3kbZv8VnJRMjpueFmuQJ5Rad
 PxtDE/yvnF9WWvW1GgHNaV7LYTXBCLbY+vG/GSQB+M7BcBYXaROcLjPLbxcT6eQJIWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792651790;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=EU5wQZL8JRp97zAjr6+JE3lhxrLUsCm+6WMe8XAx1+s=;
 b=b1jUyl8bxvoNMW1jZeOEHN1htA+g0+obKrWz7fZYK8iomms0qIknRtsKK36FOfHYSO8h
 CbmY953TSKOmIEKF6ej8POP71PdzAJnouEnx122Y++jASXVx8x+B8MBz2zHViZpFePdJa
 7+rUepfCbuX/fq5bJCqgsF6AozEQ6mjm5WC6CfRRj4wGnjR0oZUSJFu6idQUlD3YG4uUI
 gWmPgRcb9SxPj1GLCuudDao4YKI/k/DT59+PTUc8W2A3zpkSDZbIU5RHOSFLBQMJy48YK
 UM3Onbb4KEFTUnat+/zF5KSfvuf7xZDDuAISxnT+BPv1mdUB6azN5Xt0hNofM92UPvQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=gRAktVXR; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=gRAktVXR
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6C1940801
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 06:49:49 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j9Gwn6JLwzKnCJ;
 Thu, 22 Oct 2026 08:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792651785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EU5wQZL8JRp97zAjr6+JE3lhxrLUsCm+6WMe8XAx1+s=;
 b=gRAktVXRbvRn7tWsIVtrGNb49GhD9vbAx1wn8cuoPJbCb/ltesbjDPjNbXtPmnPiKsA9EJ
 hfHHmHlFhpium0o/6rq0ktI7qn1QmxnK76ftFkH1dG4hX0VWG8Gdeo4stEAlW7AjmnlKfd
 a/KPTTVPaveJ9IywV+Um7EBS73hsrK3PEBXgXWvGVdSdCJ6krKCT5C3Wv2jcEQzZqUExHN
 cVZ/hBDnZ6TmPp6O7iolHXOz5dtU4G4ETu3mh+t5Yg/WUpMWBu+CvMfjTglWpYiExKzfG5
 RgNqVScLR9EdETTtmOVQZ6uuNpz9OzOgL27KbyZjiRr8LPOcCAS+Ebdq+E8Uiw==
Message-ID: <dcfd6f4b-42bf-4dce-9220-a25b28a601ff@mailbox.org>
Date: Wed, 21 Oct 2026 20:56:41 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] usb: ehci-vf: use usb_get_dr_mode()
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261021184148.2433331-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261021184148.2433331-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 89xan1jghn6d8u8g1ggf69jny1tismzq
X-MBO-RS-ID: 8c371a5196453b004be
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 8:41 PM, Mehmet Fide wrote:
> Hi Marek,
> 
> On 2026-10-21, Marek Vasut wrote:
>> Can we do this ?
>>
>> priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
>> /* Handle legacy DTs without dr_mode property, fall back to host */
>> if (priv->dr_mode == USB_DR_MODE_UNKNOWN)
>>     priv->dr_mode = USB_DR_MODE_HOST;
> 
> Yes, v8 does it this way.
Thank you
