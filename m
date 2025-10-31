Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A97CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 17:12:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98F3683A57;
	Fri, 31 Oct 2025 18:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="c9jlpLyR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xualbe2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6FDF83A62; Fri, 31 Oct 2025 18:12:48 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA31183A47
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 18:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cynby2RXQz9v9S;
 Fri, 31 Oct 2025 18:12:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761930766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDxGlZhEk6d8BbqYqq/cPCQVSGz3s3AsepqyrIjfug8=;
 b=c9jlpLyR1PLgujkDtFDZR0W+s2tRTdr8Zrh1YT3HEaLWbhQMHIlgyYBSqpkZ30auGXH5x4
 DPllN0hDna/DoaNhI48r9tlh85jNUg/fE3nj5XkyuqgswZY4lNNGwkutPmi0S16pE8MTgT
 kd7w+ivjXS6wEH1zsdGy6eyMe59Aj19R2qzIxZ8Y8uNrFtG07G5zr7aLhGQjaVUWbDt3Ib
 /6upNargzGNf/bxFBNTrWhC0n9+gFXkyR7DaAlsXa8O0qmUPNZDj2ZCkdEkf2eIkS65dKw
 o+mkINkT0LK5CEtxxfr4PcQ98trxKMbtR120ZrKSayhxutlU6ZCuolCeNmFtWQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=xualbe2i;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <52b17e87-9fd1-48c3-9202-bd8df12b1c66@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761930764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDxGlZhEk6d8BbqYqq/cPCQVSGz3s3AsepqyrIjfug8=;
 b=xualbe2ixf4kMu+9F0t+/2bKrDl81oUuvUCClhgtVaz+96wLQEcEY+Q/FnqmVvn1gWnmHZ
 05dKz7PpTSm29/WPtK4EkvGkbO8OrwfFokxP+B42QDiMl6ach3v2Hc/IBtc4qZNrqVQ3e+
 AwjpruhbmDfpePe+xtUySYCHmTA2nUPzdSAq576l3PzEp34DH+L9GrGupFX3p3leVIWNOO
 sla7vwlwG+9S5cz2KLDL9LHUlAB281eZYZd1FGTSvroOR0CxK90JMRroTn+o91dzP8ngOG
 DkLquNFE6O4DMBho+mRLb9eH67BZ76t5iBOTFEvYv8LlYeAHj+fomLLwP7Q8Sw==
Date: Fri, 31 Oct 2025 18:12:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/5] doc: bindings: use upstream bindings for aquantia
 phy
To: Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-3-root@infi.wang>
 <6ca0b758-ac2b-46a5-a06a-5ef5ae676f00@mailbox.org>
 <7AB9A75C-6A37-4DFA-B077-EEC6A6E9C1ED@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <7AB9A75C-6A37-4DFA-B077-EEC6A6E9C1ED@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9a57ee212cf6129f9b7
X-MBO-RS-META: yi75eyrqepdpsh86u8tuy8qqatwkpg95
X-Rspamd-Queue-Id: 4cynby2RXQz9v9S
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

On 10/31/25 6:02 PM, Beiyan Yun wrote:
> 
> 
>> On 31 Oct 2025, at 11:53 PM, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 10/31/25 4:21 PM, Beiyan Yun wrote:
>>> Prepare for the switch to upstream bindings and generic firmware loader,
>>> remove reference to upstreamed bindings, also add a firmware-name example.
>>> Signed-off-by: Beiyan Yun <root@infi.wang>
>>> ---
>>> (no changes since v2)
>>> Changes in v2:
>>> - New
>>>   doc/device-tree-bindings/net/aquantia-phy.txt | 15 +++------------
>> Upstream bindings are in YAML format:
>>
>> Documentation/devicetree/bindings/net/marvell,aquantia.yaml
>>
>> How come these bindings here are in text format ?
> As much as I’d like to, aquantia-phy.txt file has always been a plain-text binding in U-Boot; I only updated its contents to cleanup the upstreamed property names. Converting it to YAML would require a larger migration, one preferably upstreams smb-addr and eliminate the file entirely.

Pull in the kernel YAML file, discard this txt file, and be done with it.
