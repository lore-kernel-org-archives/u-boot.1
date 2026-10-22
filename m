Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17A606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0Gx8p7H9;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=UNWhFFUT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D884409BA;
	Thu, 22 Oct 2026 12:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HvMjzViqW78X; Thu, 22 Oct 2026 12:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B611409BC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792673744;
	b=QvhFsrms9pGDxgUtoV/JbN8mS/FRrp506WtHPa3Zt+HcWSJGIGMNYi21qo42jkw1QTng
	 UN+MmrzLkuGVQDbv6CsKm993Uev4L3rVev5cIju7o8xtQjGnox/+p2h3oLHRIs/5NDZXR
	 BNL96ua4h8FCiBMniTNSgUSedQmx+dmCIZQ1AXYyc/aLlpIwfJrd9AfKQ/k4HYNw+xl7+
	 ME2GhhH3b+mAaso5TAkV1k4ryYwP2tyI/aDvsqmsTZ0S1p0TMoiq8winOeqWlKbfeaivw
	 QIJ0pS/SiqjKmnGNOXSpC0KfKU3gBzz7KZzkQllDoajHlcwZB/nznhz+dRNcIkgg9pw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792673744;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4382rQcSdyHpNGM8jlz6OKDfchdnv4uE/NLxbDrslSg=;
	b=Oa2LwjwSXFyGvFp1DoPtMvNTh1RCaCXa31iFl049OaxMBhaHG8sVhmNnVmX696JOG8Ve
	 5IndqjKMYIKutMJjgBk2nXslZrHxC5m7ShadBty6lq82Jox3YFX5ETTi6au9XO2dH7Av6
	 Oirg/OntEIXlvqO6md/CgR8FTT/X1asRRhjnuS7806gr3enb49bKKoqY0GC9PtaUGafPM
	 HbBgMMUFl3Y+uE7d6E2jddXlahQa5RGuB5qzM8ud2fP3LoZEkuttzYEQkUV+MuCHnsjxQ
	 Ol8ptZ1d9GmiACKC4aM1bgknnySCwddpNkSKy48e2UtFuYxNxN1S5+rLR6dKEHPFaTA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792673744;
	bh=4382rQcSdyHpNGM8jlz6OKDfchdnv4uE/NLxbDrslSg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Gx8p7H9KIIVT3CxVgmVpYXoyCpwMnXdYtXKhA6/IuuUTH6TZDB731DuzBHpE1kyF
	 dcgJzknqsxboRpDkh2SNxzNfzpVzfTPRgdbBl4VenNeswmdR1iCV22t91yHC3VwDyL
	 BuwU3IzmIH/TdjKwgOuSOqC6XjjKlQR5//yb0QiqdvqJ6+6eXF0bufU6Iu8SFRMW+H
	 TmkRYOTb7lWUlzZznE1v6DkgXdTw5G1npdd8KCEB2SLsTG6M5cgnQeOg0kcvRtyWT/
	 Agzdq/wJZWilAVqKP4vQ++8oqOQy5BQ5ds5C9IOtvGJuteEEnyjgTxHL8BsY5oqx2R
	 MdKOMRtgsyggw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B611409BC;
	Thu, 22 Oct 2026 12:55:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0121F95C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2AE8608CB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aQopB9bPwaT3 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 12:55:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B73DA6069C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792673742;
 b=bx9fJnCJVXNCcVFlyOeC+Zkgj+pW1a72ppTiyw840PAbor6OOhT8hh27914XOrYxx5cz
 v4Im2dhQaedYj+T6HIGb0TD6KVFJyxJ1M9yVH1uBXdvDMrkSokkQwpaK+LxULwcZujD0X
 lc3NPBu7R5GOVCUq0FuH5AQvSte2A/R7wHJIIaT/Mu/YIDIWWjbB3uXtgdSqLXJP84ROU
 d2CGousKwanzo8O/ni/rGBMWB5ajeyvDDJOJ+v/+hq3W2ZKOw1iVLKGpez570KQyt8D7w
 KgWinRC6rnxJKlvnfnpAbRBm8gnC4o4YCQfArPKkT4zgblMg66VZLrP257HdmOyW5JA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792673742;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=4382rQcSdyHpNGM8jlz6OKDfchdnv4uE/NLxbDrslSg=;
 b=h3Zv0aiXP9wtWqFhyn8g/Gw4U2eUce0iPYWtkMgH/VXSoqD60iKqG/96Aw+6+aeKJZXc
 rXrz7sMt+Ydv1nKLsg6AhmLt2hILGtghzdhJM7LQgsXDOtN5s3XxE+mUPMHeD9nS0n8nA
 BegNo5E9p+Srp5MNaCBpjM48WJ9hmqtXbxJL/r6m2ErcVK0m7kLdweJL3LtoPTO61q6yZ
 4RBtfs/WfgHH473E1SknQWrC5OcJdX5NXej00FlHkabsMX7rMeW4LEWqSPW7k4DBtWi47
 XymMVE/zdfNMQ2U0oG+d49/sjF0b6GDgIkrDgHGFaA5227kpkMIdgqX4XTMy8flXJmg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=UNWhFFUT; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::202"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=UNWhFFUT
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B73DA6069C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:55:41 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j9R2x6vhhzMlhj;
 Thu, 22 Oct 2026 14:55:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1792673738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4382rQcSdyHpNGM8jlz6OKDfchdnv4uE/NLxbDrslSg=;
 b=UNWhFFUTmep9F2K5WUcgO1PaeEk4XSiN8wSTv3+LP0AJ2evDNtNm/UB6D9C8zOFu6Nmbvx
 3ZqBJvwByZXhnWkwdFPyThPHlURfBO9zxQTaPlEHvDPiBnN8lPZJ+ReLQ6FgC9xooazbYi
 oaysakvHMBdJ+t5Gt/98H0850yXq0MfK3UEt9DRR14ro68p680Vdbk4Nc5Xni23LD3laIU
 6hxZ6ym3yzxvigd4fctURMwWDwAZwPAM08Ff9ViIFPkdBbqxr0gLMzxP41NE7ERAIOPNCM
 q2dcntm/9MOu7P6D6WLkfCw0CYsND+8W1btSCed1HTjXHNoEej8jaMU9qG8dvw==
Message-ID: <3b9a9c35-f676-41fc-8463-622305727142@mailbox.org>
Date: Thu, 22 Oct 2026 10:38:32 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/10] usb: ehci-vf: sort the includes
To: Mehmet Fide <mehmet.fide@gmail.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
 Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.u-boot-project.org,
 mehmet.fide@screeningeagle.com
References: <20261022070900.616265-1-mehmet.fide@gmail.com>
 <20261022070900.616265-10-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20261022070900.616265-10-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 45ee9dc5e17c12df2a7
X-MBO-RS-META: eauwbm9byo688m8jq54n9gm6eb7zarud
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 9:08 AM, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> Put the includes in the order the coding style asks for: the top-level
> headers, then the ones in subdirectories, each in alphabetical order.
> 
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>

Thanks !
