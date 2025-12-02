Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F420D1266B
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 20:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CFC983F01;
	Tue,  2 Dec 2025 21:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="kYDcd+Cd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD01D83F0A; Tue,  2 Dec 2025 21:01:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B0EC83EE4;
 Tue,  2 Dec 2025 21:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764705690; x=1765310490; i=xypron.glpk@gmx.de;
 bh=107jukj0AVZg9b0uW7rMZKlhWifUFO881fs3/sJuPCU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=kYDcd+CdoFdlSeZ7c/4dAOoeqI9nUaVxLQT2ULgZ81XL8v15/LE//qGg5cjwvKUH
 u4s20qyC93ofn/8JSOxXvsjYW1voj3rjnOTi9SZfNPiCeHXEhNA/dTLOle2l09jsj
 TixLI6z7KVf5kN5R3/woS7sPr5hir1kKTidiEbfyMmmOH4DKGJxeDEpAzpvZxISON
 2OJkvyoPGwfZaFrAwwHqhARrRX1aZUaJbG0mobBnf8PpJRb+igKKc7ckQSPUB3KPa
 Wc54OAsJ6gDSNrPkScHcAj7eXmeaWQqzGPnqcISRwVZXoV/dVit76upEosQhwe6Xl
 klgpwH7FaaYyWYdzig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.7.99]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1vHl8b1oDw-001yly; Tue, 02
 Dec 2025 21:01:29 +0100
Date: Tue, 02 Dec 2025 21:01:26 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: u-boot-board-maintainers@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: Re: Dropping macOS and Windows host tool builds and support in U-Boot
User-Agent: Thunderbird for Android
In-Reply-To: <877bv4braq.fsf@bloch.sibelius.xs4all.nl>
References: <20251202182403.GF303283@bill-the-cat>
 <878qfkbty4.fsf@bloch.sibelius.xs4all.nl>
 <20251202185222.GG303283@bill-the-cat>
 <877bv4braq.fsf@bloch.sibelius.xs4all.nl>
Message-ID: <DAE792B8-A6F7-4725-8F1F-6D874B508B74@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2hjrsQN6WoZG+g3avJ4lFWYm0ApvVJDMkDW38PdYj5vFoyUPmdq
 wjGtJqeX9Gelht6E6KZSEaLYOpR8B3iGR5DzsvaEvoHO/SHcdvbBDlBobPAmDxuyAoLXj1m
 CxRT4WQzycNOGP8WeoMXrNGdmlb/iCMgvszsXRlShDPcmvlMn09KlXG72HldJvxeFtZVsU4
 G9mK3EYh2G+bxB9qtAADA==
UI-OutboundReport: notjunk:1;M01:P0:VbKeebVEIYE=;+aSi2w44MdCOcWB+xNveLF1c2dr
 mu3Z0hsYOivSS0k0eGTVzv0aUsPfmAj8EfYJ6v/FlWzoMU70oPXyDzPKtJ/gPDO/xYlD98QSo
 n7p0hduAgG5LAlEs20/gFzjdXFpiSjt9GHki6bTo4iblAnHG5jrnJ1ACis8xxyryG5JgOPw9u
 9XnzAKpxKHaBPpJ5rpFJvIqwU8UpbQOb+I5zPlrN2Ad+sbED9NhRPFse3LW6jES9mynWLNl3R
 14frPDKcuy8tqpnAP5bEZT7X8kDYuZ+6kXPuwqMiqYAPpFJuSR9RDWpddjjbpIzIEMKM+RItZ
 PySpKcNfJleg5mcz8UCWDXHzSp6aoxNmZ4mrKukaE91cnktDZZVtCO+xYYj8KWkOQmJHEJiwQ
 ubCUsawaVDdFFdbDpBOoXLoXVQlmGRhBSGR9rkLEslexO/lRzPXsT1goRlum/jwn5SE9jr2G1
 SWEREf156CJGcbqNm1yt0DOKcEQEJvGCw39GMlQBN71C2514xGOm9+HqcQ+XMrbmCAPjdynOn
 zjGSNJQNvsfzf/Q52hD4/4fPkDijn7i3XRdaVhFJ9ZsdTeRb0+zraXsqvZPlRVpcKatqAae7Y
 I3NUYVa0rAZKoRyzQfyLUtYQKYSqS7GMix/36IDtBv6hNRCmvvJ/FKV76dIXrGhditntDcSq3
 UPSMhDFT0lCqGzY6plHs1dR+kD8bm41e2Rr7jX37P2P5HZaclf+OJIeRchElSaRiU4TD/L2uu
 zRfqvu0yXynHE+9ImqnkDEG6LdaISKB8eeJr/a+xAVANT/FQAfc60S2oSy4hKpnhjz9W63vML
 Eg60KzAVCvkAysGS3Y+/6Y4tJKK8j9rDpptb0yMF5ex1LNEf8+Y441HVKzK+/iGuqTMaRj9OD
 H3cIlWcPIvhi7l+fZq4w1NFB67pCd7RMvBq89gEAQaRJ2xDESNMAU17R1OIenMGqD728ZAj3m
 d2kkFKLJe40sZd8EIUX12tJ+14hn10IDlBhuhw97Y0Z2Z85x+pbc9WLQkZAA/bpTrG5FlLdOg
 rbRFG5RiCjh8RUggz8sPKYCdjuoWj7GPmA+vYSVZEQmaiNGVgoERYxJA6FdM235Ir9KeLoQRk
 pszQUJEF+4d3WNMPb6ljVf5dWazHiRBMklABymrkBAt45yq/uo8FretkuQUiCXURjCZZeG8Eu
 eHRuJ8CsHha+0Z4lbB3cO7Ni4E5sHahTbxZ+EiT4GlUE+EOg68/c7P+BEoyYnHqcSeGgRh++y
 j+NqNUcDLlcHfKH8TYZi345TmGbYJ0bSyqgoH+ozJcb9cKHx8+urqngC4MAlEDpLNb2CcsoUN
 1gsMXBa/WeiKvgp8+bXxR/lHr0ptQY2Auw43f8kkusKxgSJc6Yxa4FBojWT8vXDlACl4Xldbj
 0r+GLfemZGA8fdzHjkVgpZdHQYYkhMsWoGtJa3HkUCtaWeF74U4bGLGhSt5P+EPx5wvx6gpgJ
 rcsYCbIePu6hgj2CL73yTmgsZQNs9lkroRCUhOEOyIDRYfHEH70E2z2MZdghEpw6i8FTeQT50
 +oYkzE5sPyLnpQ59P0q5tj3d785jT8VFZe/XWO1yHZXxk9geGLvI8M6gU/5xBuOE2KZcJg/j1
 0Cs2CxjWHrfjFCLa5KFFq28pe/8CoW/AbC+Mv3oTS0ONY73cx5kDX2qP4NbqODNjUXXgTALHT
 47C5k1m8eVJ9OEg+7Z+cwzgWLOSVAxuzvAPf+uTU/2X/fSGyzTw/ALCDqV2aJZABdb8gcrdYG
 dTC1Ol9Xij4BL+Itcj1RGq7xJKZICMABMSnXwj1F5MQeMfZQlK/wg/OLdfmxpYbUZVB+CtXKS
 n4zK98CZ1ScTybIMrW0mMeVe7rRjgrNyoUzWOZIf9pt/lld4jYEPXYO6h9k0FvOw964gF08T8
 Rf1T755rLJagf3mqXiljPGEyR4zwHAnczhyEiDXX4zhlwXbL4jHjE9q6FHUtmasB+vggboVJr
 xbPPrF2Qv0DfAyzYVAl2YdFUfkLu7ScXnRluYSUEdQHN0pacqL0p7WNa2Nj64Qo9ctS3o7rRT
 vc16hx+yV/FHAF5Nx34oT7fxNSu6UOgajxfszfHhTYF+ZdqRJYaieC28SJTwglUfutu8fKU+5
 nCjNSYf07DoPdXbPzGdul027v2qF6Jwbq0YvnEePOFteaHlTgAAgmDJYTtf52Q5wHYcRidDBP
 u6iT/FP00X69SZL8QTVWRs5Zzrn2vwsufgBue8/FQPa6yri2AKUJtjfsGJfQePMS3V9LMHlO/
 YgucnJzs3mATF7OBHcLdGDcCkGOQHaTtvKCz2Ix9UYzMCIaVK/o4vzHmTR7fRiOJBDndyxTc+
 ET9vCXAnrWdekE9CDB96Z/youaD4PYBh7xJUF1Oo/uDEnOdpu3caOMrM+Yxihn3bhUhJLBIu/
 hw2hFzNtLkynHYJwLAxomRR8ARbyk+g1Ku8OJ5pAyhEEtO3hsFsg2odAbq9Bcw0zAs17ZheOk
 XY78ltA0VVtsMyl12FI4xc3NokBquoqyV5zJi3paPE7kzEDzeffGWbByuvyzV8k5Uj0vUn8KC
 tl1revMsfbLPRhFtUk//Ms9ZzJDmZJYCPLruzqbNmHD9pFMf1BxVpyFzt6xNC2lNy1O8vKp7Y
 SCjxcHjPVQdjtcTgHbW7HZKNng3k2OmfanGmN72n6512xhZYyKXdHl0Vai35+3Ym0JLgSzo5L
 JoSN3aa7EzbDD9wzDhd+VIg1JWhL1TyR+Hhwb8j5mtEnhVBi+Se2ui4htU6saGsxOzkfwuSMw
 rez187QrZDYedH3ZM6O0BGIRIqiDNl3AF563ZcSNP25hzgwGIxXIpWGvwUOy1irTNUuz9/rXu
 wrYGNU9x+WmwQ6RN1sepEudYUjGZkQbQRisOl+MbyBY5AdmF0UHqJlAyEAVoqo/GE3F+dgaRr
 BCGYTyiDHLADBcsIig04NfJJDsSIV41rS0TIGWInrN0/Gwjgod43Lu712R3bRmVvyHVMPFywd
 iPCEWFcTLH227hHl0OwpR9llYz2a0JTyvxHdHIZU1BJdb/a+H1uW6W69O1/uiagSd2qoLoOj4
 uvk1UXOFwCd3Vtj47syXjdpUr9428byISVb9NXvfL2bVAoV//HmJiflRpW9jHMeJ/ebvGOdc8
 zZxEfXgqehvYBdksL913Jf4lCvLvUCcpu0Ho6AORrVarl1UN9w6ZNgyXNxkuCO7kpUA41F9iO
 W08+KzMMCB9kzluTDlhjYUKA8oLQapp577KYKvYE9vRNDhB/ryOKdE4G1Pw8uXxqR+1GjWEDc
 U/38uK95Z51FDJC71Zx1/9wEfVjMV22AJ/3C4G6WY/ZpzKAsNg4I/0uXGN8rRgBkODtQvmfkx
 Mv2dc+XnMAx0JZgWdXXuZE4ols9mIz8P3s0xVXP7Vxov6FY0ILzAIF6CXbtuUDd/u40+8GOzN
 1afndeFclXU1L7vVMHZ7iY/rt1v+ZDe8NYE4vCi7ylf+MQnO8cZ9rnaYVeBIyfqyrLFme6O+t
 dFDiy35DKNKK6nJIy92KPz7aNZX2sJ+AV5cGt/RPyJu+QvagpyhEcbWPkhrXO+YTTQvp0zhUz
 OqK3GELGUjmreHTy2iNyYzbA4XkgKrjK4jAZnWywzi1vLVl9oEdiBitEmgQ897fw5sCvDcg3S
 tlf9+z7KRN0o/3W0weDDhC47EfSybidpwevxt2rsWiGvCom8Pm2rszF7fL7UwAXgixi/O+qv1
 rMo7aQEwGcO2Bekmr9K+lnaomcpCEmZHPXOaYVmdq9rAXOET1bV1s6ZwmzTUD/5qGjpRsgAJD
 hJ2BFL47XKJW3Y3cdg2t4vzajNwA90FLTNcCdm5OjK5/4kt+zhz3OQ46tJgiGy5opZ2i2fTad
 ZJXrm+vDBAPT1IYvoF03cD2/5Wi6lHFhqBlPMk9AOz1JAvmam+Ep2jvNT/JP9RcL2+kU1XGRA
 Bvzfp/gUuSotZGgu3AIqW6tnPtKT0fdBhWfr3MgfBvkI3j7LryGreEiHZ88owOWkG+f8m1lJk
 CS+yjxLwy0zpDfrSrPsd9BE/F2NsMJ+RV2/m955rOypHAYU+P1o9h49svd2DWrQ9bKdRqOZYY
 kyhWWeSLWHUBf6XQUQkGrnMDwn3TZcoRlNwxjOGtXUofq1ooWuhjVMUK0HfA+1JdDaE65alsd
 7+ETruTlIijc2xuAgFJwRYS10jwbuNmQ23drZSqUQ+HmOh0Arzo4UsGnHOBRdOsyu4jsvtYnq
 q82IBYqj9LAl23n0FRfDpzGO0BpG/KMn8cKI/Ab/8JScfZpkx5hqd8/SA/O5DVsKmiRtXkumW
 FQx0f31wwqRP+m70gJWzd9dbX6sE7xQoGVK5ETNrhaikyq1gb6rnnbE0O7otm6wlIlIFS8HOk
 VR2lyi0cHCUJllU2LMCV2oiGRKSgk55aDEuga2h0NpEQN1ya4RLb8kPBwT5VMe4OEWcnj6z4k
 PYO1Xnv+ZXRrGfxr4EMW7kNrOxY8PfQrFOQxXKRczU4BSN56QoCGVQm2HwVoSM8KxKQzzKTpg
 oRKq2HF/GEN5vl+uz9g0F0GKI+6FHXBN9EgQl6ZRm3FD8FvGvsKQjunmCMMov5Ad36S5007ZL
 Kp6SYR8dBblTEXc0hUt+Tffscybeab1LvrXdO1nhrQrfcZTkWW8YtgWR7/xeNTxdxkb6KCnow
 R5Hei0fmFzyzswQ6MRaUEC/rL1S3ORMir87vIrm9oWiB8tYmFEHpZQgIXh2RnAvs07f9IABf5
 S6I7ufOBGS4TRlutUobHB0zgDLtkyl76OGn9PkMO6Pr76b92CiFGRBjw9rOJjQ8sBrTYw4W9L
 IZByFrklDDnCJJ3nrupQBwEPb2qY/MaEqDJSPJjCdLNWVVDSm1ApVtyNFEL22K8bfiSeO+2gi
 Iy9o7BSUSIcnrYNpu2oYYMd9xbweArW+1IHdCcMMAEKsODO9Jb8vQ3cJZkckpRnW7hsGL86Lv
 MpLwN7/QK4hSPLhv/qXmh4oU/uSRsB+SQWPJ7Ba5uh/sj1TGkUKsI43k+PRAX7u/5O5yeOjtU
 UOBlEVTnqeo5ACW19JKhHBoLYZOZpHdveWzHVE349bYY1TZa8wzf+y8PYxQ0K+MworFd33xPL
 kOuI2SHZQL94hek8Zm2UNR82FGIaOaB44DuC1Ko8Ng2pVunPlVwslST90b0thfnt7S4bdnRI8
 EZ6oEjYslS6WUnhI7SK7/lo/PpuNSCyXC+p54ytdkquuK2l3mc87Tr7xrGZKtPCyepmOfgHSq
 BwR3Yc3Oc/mgLxERr2xKlYBQXslo81MJeyvtQr2Sq/xOSQlx9gcXbkGC+Rer0c/v8Vl5bjE7E
 aAAvAoGaTXKRW8v/IAOJ/ZYIQh5zO7avgBEyfyVBPQ==
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

Am 2=2E Dezember 2025 20:46:21 MEZ schrieb Mark Kettenis <mark=2Ekettenis@x=
s4all=2Enl>:
>> Date: Tue, 2 Dec 2025 12:52:22 -0600
>> From: Tom Rini <trini@konsulko=2Ecom>
>>=20
>> On Tue, Dec 02, 2025 at 07:49:07PM +0100, Mark Kettenis wrote:
>> > > Date: Tue, 2 Dec 2025 12:24:03 -0600
>> > > From: Tom Rini <trini@konsulko=2Ecom>
>> >=20
>> > Hi Tom,
>> >=20
>> > > Hey all,
>> > >=20
>> > > I am wondering if at this point in time, anyone still builds our ho=
st
>> > > tools (fw_printenv / fw_getenv, a few others) to run on macOS or
>> > > Windows, natively=2E
>> > >=20
>> > > I ask for two reasons=2E The first of which is that a reason we sti=
ll have
>> > > to support Azure (despite its slowness) for CI is it's where we hav=
e
>> > > macOS and Windows hosts=2E But at this point in time there's so man=
y ways
>> > > to have Linux userspace running on Windows or macOS that I don't kn=
ow
>> > > that there's any value to these builds=2E
>> > >=20
>> > > The second reason is more macOS specific and is that with:
>> > >=20
>> > > commit 8fbcc0e0e839a8e25f636c76e59311033d3817b5
>> > > Author: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>
>> > > Date:   Thu Nov 13 12:54:51 2025 +0100
>> > >=20
>> > >     boot: Assure FDT is always at 8-byte aligned address
>> > >    =20
>> > >     The fitImage may contain FDT at 4-byte aligned address, because=
 alignment
>> > >     of DT tags is 4 bytes=2E However, libfdt and also Linux expects=
 DT to be at
>> > >     8-byte aligned address=2E Make sure that the DTs embedded in fi=
tImages are
>> > >     always used from 8-byte aligned addresses=2E In case the DT is =
decompressed,
>> > >     make sure the target buffer is 8-byte aligned=2E In case the DT=
 is only
>> > >     loaded, make sure the target buffer is 8-byte aligned too=2E
>> > >    =20
>> > >     Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg=
>
>> > >=20
>> > > Which does things we must do, we now don't build on macOS=2E Why? A=
s best
>> > > I can tell (and for a general purpose OS, is a good call), memalign=
(=2E=2E)
>> > > doesn't exist and you need to use posix_memalign, a not drop-in
>> > > replacement=2E We could spend some time reworking the code here for=
 that,
>> > > but for now I've instead gone with this workaround so that CI can
>> > > continue:
>> > > https://lore=2Ekernel=2Eorg/u-boot/20251202162250=2E2613085-1-trini=
@konsulko=2Ecom/
>> >=20
>> > Are you sure about this?
>> >=20
>> > The code in boot/image-fdt=2Ec is part of U-Boot itself, not the host
>> > tools=2E  As such it should be irrelevant whether the host OS provide=
s
>> > memalign() or not; U-Boot provides its own implementation=2E
>>=20
>> We use parts of this code as-is (and some other less obvious files) whe=
n
>> building host tools=2E
>>=20
>> > OpenBSD doesn't have memalign() either=2E  But I can still build the
>> > targets I care about on OpenBSD=2E

We require C11 for building U-Boot=2E C11 defines function aligned_alloc()=
=2E If we add that function in our U-Boot library we can rid of the #ifdef =
in Tom's patch=2E

Best regards

Heinrich


>> >=20
>> > Or is this about sandbox?  Did sandbox ever work on macOS?
>>=20
>> It's about "tools-only" build target, but also I suspect that if you tr=
y
>> the next branch right now it'll also fail and we'll need to figure
>> something out=2E
>
>Ah, it is only on the next branch=2E  Yes
>
>  In file included from tools/generated/boot/image-fit=2Ec:1:
>  In file included from =2E/tools/=2E=2E/boot/image-fit=2Ec:38:
>  include/malloc=2Eh:824:20: error: conflicting types for 'sbrk'
>    824 | extern Void_t*     sbrk(ptrdiff_t);
>        |                    ^
>  /usr/include/unistd=2Eh:449:7: note: previous declaration is here
>    449 | void    *sbrk(int);
>        |          ^
>  1 error generated=2E
>
>Which points out another issue with sharing code between U-Boot itself
>and the host tools this way=2E

