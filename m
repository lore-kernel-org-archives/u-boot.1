Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D67E106F2EA
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AC281E18;
	Thu, 26 Mar 2026 09:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="elHbIFjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0FF838BB; Thu, 26 Mar 2026 09:18:08 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E59780517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=XTNj07VvpELqEB4m0M7LAM78HZOP0Xtw1cJNUqIFi9s=; b=elHbIFjBB7R6lJmpOgW73og+LU
 WxbZwnYA7tOTXU9XR11akP09LuFbrJZVM2jSdv9q0GUqbI37ZwvbzBdXZ1QXP/E+M47mv1qdyDoyd
 LvcuAYCYPrJFN8sTRWiS+316ZGY2Ymfz+Qbjd4JkWEkxHv8jePOBKL8UZWLhXnSYo94mJq9rRww8p
 6fwTuuJZsmxc5auoFb4Qtsr/vogz4hDHdhxqv/hWgqMXTUGeKedp+I4pkoOeLV/WG7kLXosdZGQjT
 xbjsgcswdg4I54/VslG21tSo/jWGmgST3X9q0wqsLS4vcqXy5Ivg1brI7stpw1fk06dR9wtA1At78
 ZFGnEYuw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1w5ful-000H3b-1h; Thu, 26 Mar 2026 09:18:03 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1w5fuD-000NSR-33; Thu, 26 Mar 2026 09:18:03 +0100
Message-ID: <efa2f339-44c3-4a2a-8f20-1d495e56de57@ew.tq-group.com>
Date: Thu, 26 Mar 2026 09:18:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] board: tqma7: add code for u-boot with spl
To: Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-7-Alexander.Feilke@ew.tq-group.com>
 <699c7adc-d636-4ef3-9844-52a28333ef0c@ew.tq-group.com>
 <20260325183345.GW502704@bill-the-cat>
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260325183345.GW502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


Am 25.03.2026 um 19:33 schrieb Tom Rini:
> On Wed, Mar 25, 2026 at 06:50:59PM +0100, Feilke, Alexander wrote:
>
>> Hi,
>>
>> Please wait with applying the series. I just stumbled over a weird issue
>> related to the environment.
>>
>> The default rootpath is set to `rootpath="/srv/nfs"` (with quotes).
>> This is wrong. Running `env default rootpath` will reset it correctly
>> to rootpath=/srv/nfs
>> However, `env default -fa` resets it back to `rootpath="/srv/nfs"`
>>
>> Independently of that, the variables inside load_nfs are not being replaced
>> correctly. They appear to be empty, as I get `Filename '/'.` in the run log
>> when it should be something like `Filename '/srv/nfs/boot/imx7d-mba7.dtb'`
>>
>> We will fix this before the patch should be accepted. The first issue seems
>> pretty weird tho. Any idea what might be causing this?
> Using plain text environment can be funny about quotes, especially when
> dealing with values that come from another CONFIG option and so come
> from Kconfig. One thing to look at, at least while debugging, is that
> "make u-boot-initial-env" will give you the resulting environment in
> u-boot-initial-env so you can check the output quicker than flashing
> cycles. If there's a quoting issue, commit b3087d21f022 ("env: Provide
> another work-around for unquoting fdtfile") may get you pointed in the
> right direction for a solution at least.

Thanks for the quick reply. It appears that the issue was an extra rootpath
definition in tqma7.env. Removing it fixes the symptoms.

I will send a v3 with the latest changes

