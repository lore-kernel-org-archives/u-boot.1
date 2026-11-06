Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E8606A32F
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kOEzqZHp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8H70Mab
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58B48608BE;
	Fri,  6 Nov 2026 14:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xDhg-DQTK6A7; Fri,  6 Nov 2026 14:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A225B608A4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793974552;
	b=UV/oSR2XXMXjmlXXRvq4SwwbPB241/tRqQCLcDdRbWBPSGb0s9s7gPT4cR0ItGqqaZ5m
	 NV/4c8cuIGFol+2aHsN8Lkug9KhMF1WgWV65aXY9XeMKYL+Y87xsDDuzD6e7Bp7u+vG8g
	 NZwcChgVbeVe+kdgUUMaepbz9I5StHrmleOLoQSAAGfw6yyAI7Vn1AJ6SZdJ9qenk5HSW
	 2G2x+DQ/JDZV4yB8OyS0zMhWX/zRegZv4fad1cQtuPcgnGC2oWO00fPh+t4+e9zSWdZSQ
	 tWKZQL/+WqJ5epUAICMXpMNKFIBk7qYBTBuBcF6Z9Klt9w+IejJ6RKP0l1xNW7WSu9Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793974552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9jnJOnQlupKcONLbVqXScMORJrl9+cB0AhMqNfyl4qk=;
	b=USvqZpZ/FODVabFd6zlmUcENbfoFW0medGLjwdO6xd+eBo2qtSrhm8MY9aNlbmPJKE8g
	 ejYMIaDWE53QRQCWv1Yboo5hgDS2wSzH3In8txBXt3Sl6NElzjbk74u6zJkD5avvhrh2R
	 nk42Cko/JV5n7LNvQ3sbrTggl04t8kEUZUOfqZpmnHpr2YVGLevmVMkGOd4crFACe1r5n
	 En3ik3DEMpTKY9wRsNfGWcS4gIqGGRx3rxCewSR3/P8JZBcYBZUEKpEQhjhlTCfiEt8Zg
	 1mPfkZOJLs5o7ZqS7xMd3oXfW+MKqrEg2GoqVe1xOY5TE6+r50za+fAT/n516Fv1ZGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8H70Mab;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793974552;
	bh=9jnJOnQlupKcONLbVqXScMORJrl9+cB0AhMqNfyl4qk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kOEzqZHpMf9SiEOdzU7rwrGwXty7VdRCQWsdLwqfvn9zqgmAI+LVpDjsi3WQMwta3
	 jgO04350yb9w5Lp9B6jGKqxnr3FWp4uCvRTsZpayDR9/0Wzj27KI6P03eaC3LOME7A
	 6Q0RbWzYbCINXI0fTE4QoomXQlaY3LbdeQUdkELniWvCuOHN6QITf/K8B31q5NVdXZ
	 ASDHTwRnHLk4zkaHz4qwNQ4dbkOISF1zXZOi9eGPpn9sSZRgp9L6mmUFYTdLu1ZmBX
	 2CQvLGifiO1VtcrxScpKzuZNENBy9Ft+wSivqvjxYA6Y8/hkrTl80d0khc1aKj5upi
	 bzMZwANoF9uNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A225B608A4;
	Fri,  6 Nov 2026 14:15:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6180334D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51256608A4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WAYnJTzgjF9x for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 14:15:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AC34B607BB
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=g8H70Mab
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AC34B607BB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 14:15:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CF5C7605DC;
 Fri,  6 Nov 2026 14:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1B91F0089F;
 Fri,  6 Nov 2026 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974546;
 bh=9jnJOnQlupKcONLbVqXScMORJrl9+cB0AhMqNfyl4qk=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=g8H70Mab3jpuil8tCqZ0MdskSHEpTMMxZx60VIpYQIlgj2nrOfkIdxFL6rq/J7Y5M
 xJURjANWmYs3LWbE3Y1nGESPGXwI/ruxZdqCujX2xArRi1sI87jT8BJQGQFoe+uJqe
 kaMQVJn1AD14J0BuuN6hp7VyIEdZ6/xhS4O+zjYM1ngVLHHE71JARcl02KXnQp7/m3
 7pVAtp4fVN85xGNapU7c/olK2UCELGQeCdiSX9UxZh300K7B9CXR4BGqWkGK4sYq99
 w5I6uEiM6JnI2NaGGuLTHqfiNa0TG+YWYlke4AZbMSStSbdmFyfAyL1QoYYLVRpaAR
 OST1qywmc7EBg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5/7] spl: support booting FIT images downloaded with
 fastboot
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Cc: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Francesco Valla <francesco@valla.it>, 
 Anton Ivanov <anton@binarly.io>, Aristo Chen <aristo.chen@canonical.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
In-Reply-To: <20261104-ccaione-upstream-spl-fastboot-boot-v2-5-cf9781441ed5@baylibre.com>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
 <20261104-ccaione-upstream-spl-fastboot-boot-v2-5-cf9781441ed5@baylibre.com>
Date: Fri, 06 Nov 2026 15:15:31 +0100
Message-Id: <179397453140.1035345.5595324924265210832.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=533;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=Brsth+4jNmyQxgZxn6T+66UHEt0XfNOeZq9B4ScNVGE=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq7eEI6+McYWdZcGNaPEIIyWaHXrclBgk+kuA7s
 SJ8OjrmMFyJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCau3hCAAKCRAZDR20Zk4Z
 NdvsCACq3J4X3xCPOTqCGuXMyV4/xoN7/SlvemP3GzoHqCByFAfDM8RMYKZXuUut0pX+fMyYzYV
 +jFLPT6od7I3O332u/bh3Q+KuTxErjKR7if9ir9CRNpLl5rC90kpRAbe5ZIByRi8+UpDKtWgIIC
 IOUhXAD/8pI/zi7E8cfZeei5EiK4xidfiLAZrbzBizT/4/eWV+UFkeFabi0NguquFPlhOPqMpiD
 2ED3m/6KuDnCrwYmM9qaDerxpBCq7W47VMUfumsLhdsY5zy5ss+mx5nRQu9EZuz5OSLH7m4vobV
 EpNMlrRoVIdkmdpnZrWe/pZGWy2ozUfF/kZhytjyS606olf1
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 10:40:25 +0100, Carlo Caione <ccaione@baylibre.com> wrote:
> Test farms need to run successive U-Boot builds without rewriting boot
> storage. Add an optional RAM boot path for FIT images, including firmware
> needed to enter U-Boot.
> 
> Accept the Android v0 envelope used by the standard fastboot client so
> the same fastboot boot u-boot.itb workflow can be used with SPL.
> 
> [...]

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
