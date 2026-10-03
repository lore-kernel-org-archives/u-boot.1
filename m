Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CBBCA5FE7
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C12368136C;
	Sat,  3 Oct 2026 12:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PuKUwfG2-xUB; Sat,  3 Oct 2026 12:48:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0021081357
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031686;
	b=R510T10yur+WR+z8X0T6DNmQf3DhXwEaCKYF3+2clApJu3EqGj2oLhQAHlbyh0wY/4ag
	 Fz5fvZDsenVGlCh8jJy1AJounvjssSLEwcjSQohyDPk0eJ/DdIqKNTHtWX2dacKwNHPJR
	 r+xVbGJEhG6t5HzmKfSnma8iHwuzcG06y6LaL1uE0K/mYdIWheuhKwCpODp3jii3GkKSx
	 b/yCy4mqWqfV+fB4+kPyIbG4af98I/nTV4WTQPsww/GBMfNcs+DIE38BRGFErWuAT1AP3
	 k3AHCs/n8JQpup2J83jeVDxL2X2ulHtAeEMRXbe0i4EIfK+I0S7GCcB8wGsAV28DOWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031686;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hjm5MO+Uhf1yOXMm3TFQejsZvjWrFmidozD38ixXCq4=;
	b=axU/P8Fgv2kpCqudkqMgu/28pMjsGP50wgsr9s+568QOaDZWuquCZ7dpOqyTED++mI/1
	 9fYs06JYLLlC+ok57OCLXGXSWcvzKkGyMr3BtjiujxGAOqI+JLYMgnM0ji+VnsKKmP6xe
	 /bpd9BVhdwzWhPJa6AqOxsHAUmejuXh+Nhi0dw+9VDgNuR/DTUjxbBOB+GohpVDYxL1Xq
	 /rb2mlspaTsLjvNhn5pF/NSBiuPFO9q7mzCT5ba3Fi4w/Y76sIvt0f6H6I3Fj7lh5wWUN
	 4PzwYbP5vfe2455N/+enYfp4eeKh5Mpc9ZCs/ZLnPVl8TXbO3XjqGktthwI12j3PfNw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031686;
	bh=hjm5MO+Uhf1yOXMm3TFQejsZvjWrFmidozD38ixXCq4=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=S1YBIrcUZC9xijo1zzZ/nWHAuune/h8jTnX8BwOWqpZrskCtdvPEUq6t/zIZ1sm7X
	 O8e5+wfUTfzEUep/IciDILJpG2NF5ADfojQXpCj+e+i6YyW2MDrrwWxQxx+/U5dUp3
	 gOvP9Ly8poeUrv2y9Zgu5VZifda8FCeeej9dy5G3vWR1ALUCsuXphsVa9u1oaW1ShT
	 21w6hjLwrVMsfJEfzKSFH/QvLuPDXUjUu0k/fjNSXPcFyjQydNArzidNjZHQ+h4mQ1
	 /YQVIbFFBJmZP3Zu8AKnfO3XcOpI4Y+9jA9kT3rM0N0PKBls/WzzgeTjCCUHV7FK+l
	 EyFkjmJhKFOwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0021081357;
	Sat,  3 Oct 2026 12:48:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D99D334E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 07:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB618605F7
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 07:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82xj2YivBuU7 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 07:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 076DE605D9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791012814;
 b=Jbfl1YXZft9NLJOKeuVsyNv23K9UIZKxUt93R0n8fz3lzgAApvtcdINlPXQYXR2U20ma
 zTuTLkeBFqAGDKOjyiKk42eMGqvdJWQ3SctDaZop8E9bZ0gAkFbUB4QYliQpZMGtIr/si
 XkHF2ZnJUUU9EyQ5R+38AUI59R2WjYfOPwHMgyQX+C55ez1o54AYxruZyPXienuFBBi/o
 0zzSJa+IqReRYHwbOPiBJyJNgDvKh5Z+9OqCSX+R7PuSpseKYtT9HLb1/r8szNWtKlF0l
 sepPp3/vN99BI1ye/Ujvu4S6WyN4H5zAGZtf5RWAGNb1bIR//mOplirpikZLiFKvTaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791012814;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=hjm5MO+Uhf1yOXMm3TFQejsZvjWrFmidozD38ixXCq4=;
 b=PiiBKEFmuJb3O1WJw1fxppp9FcCjvTbXr3wXCaqZIdEIs4TDVDo13Tjh6WA1WwY95edy
 YCc2rV6/YdWrShBBHczlvFFTY/eR5Y6xwsXEp4EbMPvP/xIvqSDZaSdYRTKafN9ijLC+r
 +FTlvcfBkCOBcOxW+KPnkZV7Q5QTXCFjFqoA7B3v4J3/AJGKGE0A/j7YB/I2LvolZwzEC
 WBFJhB9gB4sAEhwooRMNIf+FCeuP4YwBfUjkcPL2mM+gPwy/rbQyxo8zbVc2xfmn+XrtQ
 IIXi4mYVmAj7TYb6ljelJOH8Xl7qtXFyM9wNmr6P0zKbesXXh/0rbB4GQ7iDbRaDKPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=protonmail.com; 
 dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail3 header.b=e9ONhpHW; 
 arc=none smtp.remote-ip=109.224.244.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.18;
 helo=mail-24418.protonmail.ch; envelope-from=davewk225@protonmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=protonmail.com header.i=@protonmail.com
 header.a=rsa-sha256 header.s=protonmail3 header.b=e9ONhpHW
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch
 [109.224.244.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 076DE605D9
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 07:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1791012810; x=1791272010;
 bh=hjm5MO+Uhf1yOXMm3TFQejsZvjWrFmidozD38ixXCq4=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=e9ONhpHW8njPW4yhP9Ont9juuCyR1Ocx/fIncmRg/JC8HVtyU1g2NiQexZqS+U9jk
 vn7ZgvGCUE/tJK4yprML66y3PDlQJCgnsYZolFhVPJ6TxA5DgB++9IFnNri2WIbboj
 IGvCSlmMHEOR1dZoCmCxj7a5EK8a/6iNDXLxhWjIj7NP5AIjAPYvxWls1V6JJRyn8O
 MqO4nOCbwPgk6xhiMDrwhVYu1du6GdIdIznF1tzvYuVhHZv2dwMjHaDztsrU4qOW0b
 VDJT1ISPttKjA+UwuhnlOkzne5m8/0k07pP9id7/DdwoL2py4NCmwAfeedpa/c0jfw
 2arertelg3TGg==
Date: Sat, 03 Oct 2026 07:33:26 +0000
To: Zixian Zeng <sycamoremoon376@gmail.com>
From: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, dlan@kernel.org, trini@konsulko.com
Subject: Re: [PATCH 1/3] net: k1: add Ethernet MAC driver
Message-ID: <20261003031735.emac-v1-tested.DaveWK225@protonmail.com>
Feedback-ID: 100562830:user:proton
X-Pm-Message-ID: 3f43ea53134d335dac3a64e8468882f8cfef6c79
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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

Hi Zixian,

I tested v1 1/3 on OrangePi RV2 and R2S with YT8531 PHYs in rgmii-id
mode. I reverted my local EMAC driver and applied the exact posted
patch to my K1 lane, keeping the unposted board support, clock/DDR
workarounds and OpenSBI v1.9 fixed. Both board defconfigs enable
PHY_MOTORCOMM and ID_EEPROM. Both variants built without warnings.
The existing SPL was retained; these were U-Boot proper tests.

RV2: both ports link at 1000 Mbps full duplex. DHCP passes on the LAN
port; the isolated second port uses static addresses. R2S: the first
port links at 1000 Mbps full duplex and DHCP passes; its second port
was not connected. Router/peer ping passes where applicable.

On every connected port, each driver passed small/1 MiB downloads,
three 64 MiB downloads at each TFTP window 1/4/16, ten further 64 MiB
window-16 stress downloads, a 128 MiB download, and 1/128 MiB uploads.
Downloads were SHA256-checked in U-Boot, uploads at the receiver.
The 128 MiB transfers cross 16-bit TFTP block rollover. No DMA TX
timeout, exception or payload corruption was recorded.

Median 64 MiB download rates, local driver / v1, in Mb/s:
                         window 1     window 4      window 16
  RV2 MAC 0              15.58/14.89   80.66/82.19   153.04/151.44
  RV2 MAC 1              16.15/14.05   82.48/82.43   152.09/153.30
  R2S MAC 0             140.80/140.91 371.28/370.26  639.89/636.86

Each pair used the same physical peer and settings. These are TFTP
application rates, including peer/protocol overhead. RV2 window-1
control samples vary; a separate three-sample repeat had a 15.33 Mb/s
median. Its single 128 MiB MAC-0 upload was also slower with v1
(13.60 versus 18.22 Mb/s); this n=3D1 observation needs more sampling
before calling it a stable regression. R2S large-upload rates were
151.52/151.12 Mb/s. Duplicate upload packets occurred with both
drivers, with correct payload hashes and no receiver retries.

I repeated the complete RV2 MAC-0 test set against a locally adjacent
independent wired Linux peer. Its local/v1 medians at windows 1/4/16
were 51.59/148.59, 396.80/393.31 and 531.56/672.77 Mb/s. All hashes,
stress downloads and
128 MiB upload/download rollover checks passed on that peer too.
Both variants had window-1 samples near 3.6 and 10.4 seconds;
the variable three-sample medians do not establish a stable speedup.
The ten window-16 stress-transfer medians were 675.31/669.83 Mb/s.
Single 128 MiB upload rates were 56.50/61.13 Mb/s (n=3D1).
The isolated second-port cable remained on the first peer.

Both variants booted FreeBSD with eight CPUs and connected links.
R2S also passed the FreeBSD network checks. FreeBSD uses its own
smte driver; these checks are separate from the U-Boot transfers.
The original ESPs were restored and verified, including unchanged
boot regions, followed by normal baseline boots. No long-duration
soak or RMII/10/100 test is claimed.

One source-review suggestion: k1_emac_dma32() validates each DMA
starting address, but not the buffer/ring end. The local validator
rejects a 1536-byte buffer starting at 0xfffffc00; the posted helper
accepts it in an extracted-source identity-translation test. I did
not force such an allocation on hardware. Checking the full range
would retain that protection when allocations approach 4 GiB.

Tested-by: Dave Klotz <DaveWK225@protonmail.com>

