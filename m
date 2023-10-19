Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0570CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 20:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D99D874D2;
	Thu, 19 Oct 2023 22:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="hfFWVp9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36BE48746F; Thu, 19 Oct 2023 22:49:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 622E587209
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 22:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697748591; x=1698353391; i=xypron.glpk@gmx.de;
 bh=3R9C72UsZDnoIes2R+4nhZYHPSJzVZ4x4MY5PPZHvoU=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=hfFWVp9ezdwIQbVSqOYW0b6lb8vAqCW4YH7s9lqSra0e8L3y+ZB5S8elkzUnrZec
 IzsGXV756V84wsNEbUHaNWOtqeTYbEiUx5ZFI75ryhWgdcmZiSuX+2MmqBZcZ8QcL
 Y08EKZ1QPCDkXDSpIBp/JAx9F9CjbSqdaK73KPZ5/NdVwX0xzf1TEb8gphCawPG1B
 qK0Wwo+IizDTIgTay3fznYyLXs/Olgs5pR+4iQJjXFsuj8iGYuDuX4Hv0F2pxrJOY
 XfSbsZ9F7FGcxsONgOp9YYynYjVfUL1JW3H52ScChAhgvqgrkUfMm2YRZkRbD6det
 ypBGBB69aVUAH9duEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1r15v80tq9-00YOxw; Thu, 19
 Oct 2023 22:49:51 +0200
Message-ID: <baee495f-8326-47c5-b89f-56a62ea95b9a@gmx.de>
Date: Thu, 19 Oct 2023 22:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Randolph <randolph@andestech.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Falcon mode on RISC-V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:40H2CSB7EAP4ucKDZdSMF6wQDso4A7TE+sVD5VUoD2VN9gV74Rv
 vF/5f4Tki4w8MZuDIwkpyAxQORoxNofUd8UZ4qlvcOZt2ZJtE+XuEcgG34PGKk1X40/yJZx
 TaXRq7vYufJFtKyktt1ESs3gxrefHdr35WPOvycFrjf+dl618SPKTQsO6RtQGgzqW+XexHf
 QyW81ssmwb/zv3GJE3p7A==
UI-OutboundReport: notjunk:1;M01:P0:ElgzQjBnf4M=;Q5TkBoFbhxaaeS9TtikfNVTbupG
 +DGstfoGHvkkEsFyOt8pWdyboHJmZIAvq2FPpzEUZQ/QVFsEv5EkgiYNoDRorRzsUfiEctHUv
 u+ezphV2Zk80XA+5IFOSEOzYyy963I0Vq76UTur4awoSknNNuN9+pMrSUNqRf4JpiBiaucFD1
 VZG4HRyOK+EmnNsJhyE1xG2HE6GEvRxz1bv7FKyJazx0ej3opBMjPO6VEPRFvSOI08TA/Uzgw
 XjMWsrgVMyfVi3fH6lZ3pZHOHjfhosiv6l7J5oU8hN+bRiyXJ67tjWswgOyuL6nOAPE3UMIBO
 WN4kUWlX8cMSdEsNyrdiRdESlJ5vUF833dsTH8nob0OqrHBapgrlHCNp5iefmG+4BUh0QlFED
 qFqGpKNlXGCvMg9xXgG2FqohH/+NgMGwkpFnz1cINOrgai/nUH2T5x/YTO+dlRKBQceRRTLmd
 SIfBqM1kNkyv0huTKr55BEuparUUcKoB2Amx5gLbBau/+x/5jmKM5RWXD2mqghoGCA+kHMi41
 TlZ3MmSJmnWV4Ilut1sc+L798IzbYglYR2khHw7cDKZdCJS8Z9RTBCtuUh5IKmSbfp9fRrf52
 cJoBJbHdJHmPOt483qST1M3y+KB3SGp8fZ19BvHRhPGh6yqpsDEqRNLgbLocahfn2keg1/UOb
 xtQLP+Yxaffowo50ZX2usLDxGZ7oTPrT6om2sXceF0xLZCXtQIyDkhM9o7t5teRL0gaEzk5JO
 89Srchz+jg38IpuIB14nrLjd8laOeZ6GR3eAUCl6rTspkrhjdvpwsLFzbk0yNPE94OVW39a6/
 zIKNpZWv3UiMaQNCFMyJbTDuOIHlTf/aAT7eRM0Yoj5BxM/6h+PRahXhhQN5SuxVLgHUzJbf+
 uOdRNC3rTnKdDcOGyr5xYecUb4/Qiszk39+R2SivYQNEnAwFSWYZ4sRn2Yd/KfsMeueDVH0aj
 PGbGGIjHdljooN6ZKEtniYuvZsE=
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

Hello Randolph,

I just saw your patches merged to enable Falcon mode on RISC-V using
CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT. I did not see any documentation updat=
e.

Should information about your development be added to
doc/develop/falcon.rst? Would you be willing to provide a patch?

Best regards

Heinrich
