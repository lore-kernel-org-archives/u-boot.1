Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FE5C19F32
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 09:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24F0D810EA;
	Sun,  2 Mar 2025 10:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XNuJuaSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B420810ED; Sun,  2 Mar 2025 10:39:37 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A04E80050
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 10:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1740908374; x=1741513174; i=xypron.glpk@gmx.de;
 bh=6oJd62dHPI2AZ8004Im/v/8399G35CamXtF06jCWgzg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XNuJuaSyMmy6rehzIeuoRSVy1J2yNuDG93svnVaFuUHQZRpiG69pFG5+WK9JD3b0
 mm+s+3NdqHmEHOrifpCUJ/z0cqbnxdk5XhQ66Q2YK407qUQJ0WeZ7TJCMDgOr+iuG
 oMtcq6A499oNfUVuza2Xi5dnrA3umK5avTAQxzr3NxXVtI+iqLUsyOCZDonJxUNgX
 FMeiqBrRfbIQMiyMloJqRxndvKYi9exWbizoSLwE0q2MN7UWn8UOwNOWYSzFpIN/F
 uRauYSxv+4UOmZUVKBqjRgS0342mKQ7nPhGNvq0Y1psJthMibp2LvpLAxoxT58JEx
 /GBB3/rsCYs4/5sbRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1tC5RN3CSJ-012Jmw; Sun, 02
 Mar 2025 10:39:34 +0100
Message-ID: <6025f42c-6c74-4ac0-b0c6-42b55d124cd9@gmx.de>
Date: Sun, 2 Mar 2025 10:39:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] EFI net driver - series 1/2: Support multiple EFI net
 objects
To: Adriano Cordova <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
References: <20250206174018.465530-1-adriano.cordova@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250206174018.465530-1-adriano.cordova@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:78vnDvZ6GI5AfdQFQ+LfrAnCOZn/S0AZu6dt7r9mCUAlMqfL6uk
 FOpRF+cU0XvFlxyATem9cphrDofvZs+9ohLKxtYaqkPnMDAukgzCtaAMzUFbaX/5nrkFZfX
 jVe8zL0rW3ByCFFpa5335XNDPvTz5GokvU/o/mAaeaLXb/xGu8woje7DbqDRY+Xu/Ga6aP0
 PSTl8kT1TqtvYPe6XK9nw==
UI-OutboundReport: notjunk:1;M01:P0:Md/Ii/HP0Yo=;HevfQfDecyiKHpLIBE3GjWlOWyH
 sLBY0ro3fvQpnMc6POscvUzQl6Mq8fbRPycW3+d6+/J0vi9I4rL/AdcAl/6ZPIIIbIOftPbbT
 9T6tHe8jJP/51MNupUAQz2BQyopK/bclfOG3+vX7+hD4nBEL2iZjJkZVGi7/9fD6gbjNqpXyx
 eyOHT6KXBkEGm138Ae9qe8T/4zkGUBByszFuW3EsLhAmEtcs15vY32wDDt6Dz5xNtjPv0CJGR
 zISpSUfsycmI2Uj6RxoDa8qVxDlg/oKCm2LdE1SuuJdovJq8b4wzZjtQwH+VcaW5KEn7g1XPB
 qtiSLJnrGpmdGYtkR+BTSzKxfa9WiHunknf7d1X4jz8kz213GmV/eZhtVATcqFY+wO/wBlkgv
 bByOEQL6e1zyA9EJFnqu4gHW3SbrfrpCkP17OKiyR8Qr85MpwNy+tQeAVqjyn+2nnhBQqRytF
 Crh15jEtlqkOt6l8pB4rPEoOwkjTA2swR76CkAAJbBjCBZ9UCqnOwsxIR6WMuTv+mLoWeH0nR
 ImKfezfn2hc1bgLg5RRJuJjBpRJ3VS2ZO62xj/U6+3SlpNOYaxHpUzEM8CqDuxIlrae5GmZA6
 vBTzSQPKvNeCL39PIO4v1SfEwCoL4g2Bd5Z0Y801as9dycYGqxR9XjD5669iF4fJzSzU9NAu7
 bcLZigZJ7Xatya29t/AwtqdARaaosMiCjiW89/IPEhHyK0I5Th9agtGiFfGH5hD14MN2v5fOl
 UzaybQ4GaO7+wWfQPbW3aP3bFp9P/84Ca0mzHbixnTYeFb+j74sH06uG3ZlfJIYJpVmKYqaVY
 9HHD+jkFDOAuIjv++qBvaz46fLiE1ixp0v0Kh++0jKg/1/2FfLftz/+qOaCicmWu61i12EQ/o
 viLOFESMl5UbarTn+gueZedLlHT3yVzBkM6lC/n6nEpt/Io0M9Otuu1GV8OxzD4Q4sRBUJouu
 jE/myJG+D2jbeEI7X0qdqhyrGtJ/pYihfhESzIWZHA9BU94hhkClY0p97QjVSGC7lmm0G5aiL
 CaxUcZosM0HR/19JnqhldEYf5tSeJjslbj2owgYPccmg4rfo+04sTfpSVNPHGMXLIuqLQAZVK
 KdboMZt5MOYziAp+eZNa7mbYhIyJ4RjE8m24eKVKfRdZsixMidOZ7rIWAZ4k6YhrKrWu6f+Eh
 KMIFQJjatvw2t7nJ+aVpQrzYgrAEZk/uB7kCZHuS7DzcbbXXBhQYluvW3GFlahoyG4f4xzq76
 B4bTe6Dc/mXqHvQz7IpVk28H/BrNVAhTUOFYfv1gSJlv0ZYXPbOy7+3CqBODnjTVIOBHO+LUk
 aQWayL1tMLyiU3CvfpVa1Vv/jNv0wow5QGuGucQDaQT7ACyj5OU6DMTdWsCqmvFsIQrIUwHaq
 5nin0FsZkqpXUIIZGnBM8Cm3loFbco0NPjkSLtjZ9ptuNiijorXXD8LIuW
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

On 2/6/25 18:40, Adriano Cordova wrote:
> This series adds support for multiple efi_net_obj structs in efi_net.c.
> The EFI network code still only registers one efi_net_obj, corresponding=
 to
> the current ethernet udevice when EFI initializes. In the next series th=
e EFI
> net driver will [de]register ethernet udevices in the EFI network code a=
t runtime.

With this series on top of origin next:

Setting up 'simple network protocol'
lib/efi_selftest/efi_selftest_snp.c(228):
ERROR: WaitForPacket event missing
lib/efi_selftest/efi_selftest.c(89):
ERROR: Setting up 'simple network protocol' failed

See
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24921
for details.

Best regards

Heinrich

>
> Adriano Cordova (8):
>    legacy-net: wget: fix wget_info handling after new tcp legacy stack
>    efi_loader: expose symbols to be used by the EFI network stack
>    efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
>    efi_loader: efi_net: Add efi_net_do_start() to efi_net.c
>    efi_loader: efi_device_path: Pass net udevice as argument
>    efi_loader: efi_net: Add device path cache
>    efi_loader: efi_net: Add dhcp cache
>    efi_loader: efi_net: Add support for multiple efi_net_obj
>
>   include/efi_loader.h                |  48 ++-
>   include/net-common.h                |   1 +
>   lib/efi_loader/efi_bootbin.c        |   3 +-
>   lib/efi_loader/efi_boottime.c       |  21 +-
>   lib/efi_loader/efi_device_path.c    |  26 +-
>   lib/efi_loader/efi_http.c           |   6 +-
>   lib/efi_loader/efi_ipconfig.c       |   4 +-
>   lib/efi_loader/efi_net.c            | 577 ++++++++++++++++++++++------
>   lib/efi_loader/efi_setup.c          |  27 +-
>   lib/efi_selftest/efi_selftest_snp.c |   1 -
>   net/wget.c                          |  18 +-
>   11 files changed, 572 insertions(+), 160 deletions(-)
>

