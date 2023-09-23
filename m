Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C1ACE7A8A
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 01:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 176CF864F0;
	Sat, 23 Sep 2023 03:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MHvFs7oI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3A386501; Sat, 23 Sep 2023 03:38:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44FDE85DEA
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 03:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695433091; x=1696037891; i=xypron.glpk@gmx.de;
 bh=V1vOXbOSxjH/soCDm8O+qDG+vmccnRjbYBdECkZNAKQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=MHvFs7oI8jkfczWKQRkVODXu83H+tevUBJYECTOCX98zeTsIpW2WoDehdrxn2phKzMFhNb0d1Xn
 1CMfkCHAyIv1PzIQa2BTikYtctJFTsYSKmhugN76+ZfVaF0okY4y6Eq+D8V3epnoo2J/kvzHfEaQa
 Nt9NJQBOK7NG9BbicJJgZ4Wa5ycEFz62kS30nDQSme1RVthcYY4HOwS031Z4fJE1RXc3unKLyGWdA
 t5a94hIHVbqUPsbBQEYwwa5n4DJvh4HXl1a9UUVqMSLbnJ4nBuexdZaoZmmAOkR7Es9PHec9G0AVI
 Ikh5q/2KcAEzCobnPyMOZfslLjiUNmuZEdrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTAFb-1r6fPw291T-00Ue4f; Sat, 23
 Sep 2023 03:38:11 +0200
Message-ID: <e43c5b16-e626-4c7a-9bef-44f192d2a703@gmx.de>
Date: Sat, 23 Sep 2023 03:38:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Reading from ISO9660 in U-Boot
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>
References: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yT5/lc5f/mbW5n0B1wmnhXjYXDAPuoW4oYwcW0aEmmq29sBmmix
 T0+xa8fcZGjzZz2HOUdBVc4DU1xo5JQv75GWoW4GvIw2gxN3MtxwpTuIOn5KfHV8d1fs+bl
 AtV2pQ9CZltsaWgIN8tjlwKtvvniDbsxGSHYhliTvip9qR6YnsGpCCvvjydUpFNjeV+osm2
 oKHvK3AacQPJ02MucEIQA==
UI-OutboundReport: notjunk:1;M01:P0:uw63+5izuBU=;gM4EGgcWAHCLoGmOcKCvl4wsy0t
 A6SXDmZHzHQcUd9Nii4VmacJtSIs0D6l1cfwc7q6CE4FBlHca0/MfgJ5jHou8Ymm2LfpCAVAa
 gmxcVm2cx/pCjSTPagRskXIQr0WZRhzI+5J31uPu40fYHWlh0mX9ETVJEy1YNWCpGSL6fuEpK
 A6detM24BRO8qdkYakiHhSsJ0ga1gWseU62oq6qRorbIsNzjXLPUgthJKDYOz/k7NXskVhd6j
 99l1uhpCKGahf6wslF0t1zYKy46ZUJqeevGqXX+EJ0phC8cOVxkS6HAjFxLxa2WHdSDpPO3UW
 iAejIw6Kb0OkANrOJ8NSLoljlZ/c4GAA9t/XoxArwNiQK8fWWeejO4nNhu2R+lXPVRkxGnxm/
 iTpf1nohlV8zw0ab4l4h+2K39esn7J8dGoi+CVOiGLrEqRLeK5f8bFlyfRzktfBx5Fbu47C2+
 l+7fkZcCb2kVpSsTmiqkBVjpC0BEx6GxPVaHheCreDSwAXWLUx5QV1CYiZjf7kS/LgiRIvQXN
 TlCaDdtOOFAm8+RFl9jppQtc9hyMp0K1dsPFbM8sQbdnHlsy66/GXwrr3glT6gXjKd5pfND8f
 0jQWnG4RqTwV70bhYih93aJlkmoK+UYL4FkjtjdD7R38eO7ywsLx1D0xaJHlGQFWfvhJKWY0G
 t7vfVdm2G4IRuR//hQxxn0zwCMB6QFp4xFKC/U2A+gV1qncUZURFOKfWEZty4hqQ0VkX1Schu
 tifbfy/RmqwPmc2wO4c85jbVqH5jgxmVU/APU5QebVdQB9CqWlAjchJFF8Ihunpa4xewSgDO8
 4kQBnXJX9nG77DJZrH9V0xEriuOP3/fEoLxr4dquCZ07s0okzKbz6fPlodkFJsl6U+68VAHuu
 O0W64S81yx+BxCk1nHzKMhGePRA9qHGWswQfQIJOk+TUldltruGUoFN68yshf3jkgXkW8KSjt
 7KWAlmbHu3HqymeZPPVDf/5ytSY=
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

On 9/23/23 00:13, Simon Glass wrote:
> Hi Heinrich & Bin,
>
> I'd like to be able to figure out in U-Boot what OS is on a USB stick.
> For example, with the Ubuntu installer, I can boot it (through grub),
> but I cannot see how to read anything useful from the USB stick that
> would indicate that it is Ubuntu, what version it is, etc.
>
> Does U-Boot need an ISO9660-filesystem driver for that? Is there any oth=
er way?
>
> With Debian I can see the actual files (linux and initrd) , so it is a
> bit easier.
>
> Regards,
> SImon

U-Boot only needs to support reading the ESP to boot. GRUB comes with a
9660 driver.

On Ubuntu server installer images linux and initrd are in directory
casper/ in the ISO9660 file-system.

There is also a file dists/mantic/Release

$ cat dists/mantic/Release
Origin: Ubuntu
Label: Ubuntu
Suite: mantic
Version: 23.10
Codename: mantic
Date: Tue, 19 Sep 2023 23:07:01 UTC
Architectures: amd64 i386
Components: main restricted
Description: Ubuntu Mantic 23.10
Acquire-By-Hash: yes

Best regards

Heinrich
