Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E20CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 19:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F24E8319C;
	Wed, 10 Sep 2025 21:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="one44Rj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846B683280; Wed, 10 Sep 2025 21:42:40 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65A71830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 21:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1757533350; x=1758138150; i=xypron.glpk@gmx.de;
 bh=p6QcAoa8uqoarycOSN9NBe+pcvg5IQ1UH1asaIDNYh8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=one44Rj31RHgsoBJBeMYSxC6TCihPXECxLR3Ae3vNKsPt/qYimU0rbDe0QeJrURc
 zoSqGHkjcr+b7adP8lJ0NJ3tTsyAIUi8kWzV/K76ybQxINzZ9tPFZ3/ZSwvONykWB
 D/iy179NgyTXCzzX8C2aohpFXXV8+lqRwICh3UBnYwyWBsctri7iRH2mvyRbrIfJg
 r73MDza4MPxUloShOvBnmwRYsHkLlxL6pWljU8Zfc5tW6LvW+eGBH8rX+nIN/Bfc5
 HDxdRqLWUT+QCnjtIYCYgH30PFRiIcYmcC7h0tbExwXp+2G3amhHQkO/h6pjducsw
 cvsVKvls93YWIMK/TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1uyusv0uoF-0073PQ; Wed, 10
 Sep 2025 21:42:30 +0200
Message-ID: <e639a9b1-a745-4099-b9e7-2a7fc411e1f9@gmx.de>
Date: Wed, 10 Sep 2025 21:42:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 9/9] doc: board: amlogic: add u-boot-spl documentation
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 ~postmarketos/upstreaming@lists.sr.ht,
 Ferass El Hafidi <funderscore@postmarketos.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Beniamino Galvani <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
 <20250907-spl-gx-v1-9-37395d9ff5af@postmarketos.org>
 <12661062-d02e-41aa-aa57-d83c05688d7f@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <12661062-d02e-41aa-aa57-d83c05688d7f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:to6Omfg6cK+YKoi/pyLFpranNqSA+nrwL1tgDjbNprk/gADhF4o
 O6v7P7tIwdHW1gZhmiqtbf+NxbGKDhFV/QLWwjiYBWulIUB9u7yNxnSFobt3h3Tx8SoNFf3
 0Moes5itOYZUWI2n6/EMd0mhKEWnBGdOOMBDwJBkeopwedT32EPJWBBgEGxqG50w9JBEacm
 WY2ow6LXtBOBRzkCRzTLQ==
UI-OutboundReport: notjunk:1;M01:P0:966X/70XXF8=;33ToUMSunbKEKZ1VA803mSzzH6x
 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
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

On 9/10/25 09:03, Neil Armstrong wrote:
> On 07/09/2025 16:36, Ferass El Hafidi wrote:
>> Add building and usage instructions for SPL.
>>
>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>> ---
>> =C2=A0 doc/board/amlogic/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 doc/board/amlogic/pre-generated-fip.rst |=C2=A0 9 ++++
>> =C2=A0 doc/board/amlogic/spl.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 77 +++++++++++++++++++++++=
=20
>> ++++++++++
>> =C2=A0 3 files changed, 87 insertions(+)
>>
>> diff --git a/doc/board/amlogic/index.rst b/doc/board/amlogic/index.rst
>> index=20
>> dcd935224ac0280a77455e3475a610fd81cfb80d..23380ac33f2b06efff7d4741ce296=
7d75671ca13 100644
>> --- a/doc/board/amlogic/index.rst
>> +++ b/doc/board/amlogic/index.rst
>> @@ -78,6 +78,7 @@ Boot Documentation
>> =C2=A0=C2=A0=C2=A0=C2=A0 boot-flow
>> =C2=A0=C2=A0=C2=A0=C2=A0 pre-generated-fip
>> +=C2=A0=C2=A0 spl
>> =C2=A0 Board Documentation
>> =C2=A0 -------------------
>> diff --git a/doc/board/amlogic/pre-generated-fip.rst b/doc/board/=20
>> amlogic/pre-generated-fip.rst
>> index=20
>> 6a43d776d43f35cbffc7ba9e72bf05dd719f6387..d820bd09115952d4fca2b9e7d7b5a=
9e30bd11430 100644
>> --- a/doc/board/amlogic/pre-generated-fip.rst
>> +++ b/doc/board/amlogic/pre-generated-fip.rst
>> @@ -98,6 +98,13 @@ The repo also provides the following files used=20
>> with GXBB boards:
>> =C2=A0 The repo also supports the open-source 'gxlimg' signing tool tha=
t=20
>> can be used to sign
>> =C2=A0 U-Boot binaries for GXL/GXM/G12A/G12B/SM1 boards: https://=20
>> github.com/repk/gxlimg
>> +The following binaries can be replaced with open-source implementation=
s:
>> +
>> +- bl2.bin (GXBB and GXL only)
>> +- bl31.img (GXBB, GXL, AXG and G12A only)
>> +
>> +Refer to `Experimental U-Boot SPL Support`_ if you wish to replace the=
m.
>> +
>> =C2=A0 Licensing
>> =C2=A0 ---------
>> @@ -129,3 +136,5 @@ clarified. The current Amlogic distribution=20
>> licence is below:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // THEORY OF LIABILITY, WHETHER IN CONTR=
ACT, STRICT LIABILITY,=20
>> OR TORT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // (INCLUDING NEGLIGENCE OR OTHERWISE) A=
RISING IN ANY WAY OUT OF=20
>> THE USE
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // OF THIS SOFTWARE, EVEN IF ADVISED OF =
THE POSSIBILITY OF SUCH=20
>> DAMAGE.
>> +
>> +.. _`Experimental U-Boot SPL Support`: spl.rst
>> diff --git a/doc/board/amlogic/spl.rst b/doc/board/amlogic/spl.rst
>> new file mode 100644
>> index=20
>> 0000000000000000000000000000000000000000..39d50e3da87d71f62cec1903c441c=
334bf7020e8
>> --- /dev/null
>> +++ b/doc/board/amlogic/spl.rst
>> @@ -0,0 +1,77 @@
>> +.. SPDX-License-Identifier: GPL-2.0+
>> +
>> +Experimental U-Boot SPL Support
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +There's some experimental support for some Amlogic SoCs, in U-Boot=20
>> SPL.=C2=A0 It
>> +replaces the proprietary bl2.bin blob used for DRAM init.=C2=A0 Curren=
tly=20
>> Meson GX
>> +SoCs (GXBB, GXL) are supported.
>> +
>> +A subset of Amlogic boards have SPL enabled.=C2=A0 These boards have b=
een=20
>> tested and
>> +known to work to an extent.

%s/known/are known/

>> +
>> +
>> +Building Arm Trusted Firmware (TF-A)
>> +------------------------------------
>> +
>> +This U-Boot SPL port requires the BL31 stage of mainline Arm Trusted
>> +Firmware-A firmware. It provides an open source implementation of secu=
re
>> +software for Armv8-A. Build it with:
>> +
>> +.. code-block:: bash
>> +
>> +=C2=A0=C2=A0=C2=A0 $ git clone https://git.trustedfirmware.org/TF-A/tr=
usted-=20
>> firmware-a.git
>> +=C2=A0=C2=A0=C2=A0 $ cd trusted-firmware-a
>> +=C2=A0=C2=A0=C2=A0 $ make CROSS_COMPILE=3Daarch64-linux-gnu- PLAT=3Dyo=
ur_soc DEBUG=3D1
>> +
>> +Replace ``your_soc`` with the SoC target you wish to build for. For=20
>> GXBB it's
>> +``gxbb`` and for GXL it's ``gxl``.
>> +
>> +
>> +Building a bl30_new.bin binary
>> +------------------------------
>> +
>> +``bl30_new.bin`` has both ``bl30.bin`` and ``bl301.bin`` binary blobs
>> +bundled. The former is the proper system control processor firmware=20
>> and the
>> +latter is a "plug-in" for board-specific DVFS/suspend-resume=20
>> parameters. For
>> +more info you may wish to read this page: `Pre-Generated FIP File=20
>> Repo`_.
>> +
>> +To build using the FIP file repo, simply issue the following commands:
>> +
>> +.. code-block:: bash
>> +
>> +=C2=A0=C2=A0=C2=A0 $ cd amlogic-boot-fip/your_board

Where do you get this source tree from? It is not contained in TF-A.

Best regards

Heinrich

>> +=C2=A0=C2=A0=C2=A0 $ make bl30_new.bin
>> +
>> +
>> +.. _`Pre-Generated FIP File Repo`: pre-generated-fip.rst
>> +
>> +
>> +U-Boot compilation
>> +------------------
>> +
>> +U-Boot SPL is not enabled by default, instead there are config=20
>> fragments that
>> +can be used to enable it, with per-board configuration:
>> +
>> +- ``spl-libretech-cc-1gb.config``: 1 GB LePotato board
>> +- ``spl-libretech-cc-2gb.config``: 2 GB LePotato board
>> +- ``spl-odroid-c2.config``: ODROID-C2
>> +- ``spl-videostrong-kii-pro.config``: Videostrong KII Pro
>> +
>> +Pick one of them then:
>> +
>> +.. code-block:: bash
>> +
>> +=C2=A0=C2=A0=C2=A0 $ export CROSS_COMPILE=3Daarch64-linux-gnu-
>> +=C2=A0=C2=A0=C2=A0 $ export BL31=3Dpath/to/tf-a/bl31.bin=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 # Upstream=20
>> TF-A BL31 binary
>> +=C2=A0=C2=A0=C2=A0 $ export SCP=3Dpath/to/bl30_new.bin=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 #=20
>> bl30_new.bin binary
>> +=C2=A0=C2=A0=C2=A0 $ make <yourboardname>_defconfig spl-<yourboardname=
>.config
>> +=C2=A0=C2=A0=C2=A0 $ make
>> +
>> +Write to SD:
>> +
>> +.. code-block:: bash
>> +
>> +=C2=A0=C2=A0=C2=A0 $ DEV=3D/dev/boot_device
>> +=C2=A0=C2=A0=C2=A0 $ dd if=3Du-boot-meson-with-spl.bin of=3D$DEV conv=
=3Dfsync,notrunc=20
>> bs=3D512 seek=3D1
>> +
>>
>=20
> It's very nice :-)
>=20
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

