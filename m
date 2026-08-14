Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C54C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C626160A6F;
	Fri, 14 Aug 2026 22:44:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Krq8GNsUzjIc; Fri, 14 Aug 2026 22:44:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C60260738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747445;
	bh=ESbf5m8EwWHECq9YyM8fVcHjtwzxoza+ZU81eo16gp4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=TEB8G9AW1q9nBEhDQD7CvWfJEJglG9M0bXNkIa5KRsaG2vEmw5K55FwiN/FXu2zz8
	 jOcBkI5iuZtzhSwN5GbNjoMqCQHofL+ThovpM/ih86atcvQhZ/BnZ+aaMalbMfNDkR
	 acT65cqsk2ecIowHbd72C3qsSsAi0yWixtUe1TM7ov+t2jy9YZ2Ky7drizNXbN3DIK
	 voz5ZdIvKmRyi1tWwQClii/ApNVWXhw/ywoB/TRAwmowJr02Pro676SwMamv2pi6TO
	 pD39DOTtwUhO44O254oG4dwJEbuIELVzuK8kSngZsIRj40fmtweUWpQO5nsLl0tOsf
	 c5/SyHEocox6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C60260738;
	Fri, 14 Aug 2026 22:44:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6FA23A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4EC540180
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pe5eA5ujhlBI for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E6BA240080
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6BA240080
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E6BA240080
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:02 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hMHMf4pDHzMlCm;
 Sat, 15 Aug 2026 00:43:58 +0200 (CEST)
Message-ID: <68bf41a9-8b6f-4d55-a0d4-9b999022b06a@mailbox.org>
Date: Sat, 15 Aug 2026 00:00:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] pinctrl: renesas: r906g032: handle pin subgroups
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260814-rzn1-2026-10-pinctrl-v2-1-95dec872b1ca@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-pinctrl-v2-1-95dec872b1ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 94ee14f87d647e8e9fe
X-MBO-RS-META: 4ioj7e5nuji8jfpehmpp8jney65cj659
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:26 PM, Ralph Siemsen wrote:
> Add simple recursion support to the .set_state method. This makes it
> possible to use subgroups in the device tree, which in turn allows
> setting multiple pins with different bias/drive-strength properties.
> 
> Fixes: e4aea57fa773 ("pinctrl: renesas: add R906G032 driver")
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
> Changes in v2:
> - split out of the series "Renesas RZ/N1 additional drivers"
>    https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-1-af2ce80db9d8@linaro.org/
> - fix typos in commit message
> - use device_foreach_child() to iterate child nodes
> - move recursion to top of function, ahead of the early return in the
>    case of no direct pinmux entries, instead of removing early return.
> - dev_err() in case of failure during recursion
> ---
>   drivers/pinctrl/renesas/pinctrl-rzn1.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
> index fdc43c8e714..6c8d40e9639 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
> @@ -298,11 +298,24 @@ static int rzn1_pinconf_set(struct rzn1_pinctrl_priv *priv, unsigned int pin,
>   static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   {
>   	struct rzn1_pinctrl_priv *priv = dev_get_priv(dev);
> +	struct udevice *child;
>   	int size;
>   	int ret;
>   	u32 val;
>   	u32 bias;
>   
> +	/*
> +	 * Handle subnodes recursively, so that pin groups work.
> +	 * Note that properties are *NOT* inherited from parent.
> +	 */
> +	device_foreach_child(child, config) {
> +		ret = rzn1_pinctrl_set_state(dev, child);
Can there really be infinite nested subgroups , or are there always only 
groups with subgroups and that is where it ends ? Linux 
Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml 
makes it look like the later, so maybe the recursion is not necessary 
here, instead call device_foreach_child() { device_foreach_child() { .. 
} } to prevent the possibility of infinite recursion ?
