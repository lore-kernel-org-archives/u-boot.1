Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548EBCCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 14:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D211283655;
	Fri, 17 Oct 2025 16:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="OVeJwSr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2988083734; Fri, 17 Oct 2025 16:18:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983258309A
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 16:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760710691; x=1761315491; i=xypron.glpk@gmx.de;
 bh=Jl2F79krNzk0PSVFY+Xr88UPJpHsePwiTUuX+hXRDFg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:Cc:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OVeJwSr5+uYc23mU9ZQDWYnPB11TUko2doH6iQiIw7pCk2TIo5/yM/dDFJF/A8E6
 cAxaQEyNRMjAO5SJ4bKKnMgm7YJjzPcMjO4H609F8N4EXua1CV6wwOFpejoNtU0Vk
 VtTSRvLhDMSKVjgA/1XWWXWjll1K120KybGxhvcgNSe7rkfbrPauNTTLzJqQGcmC8
 0+al7VACdvtUFJDpubY7D9xr5omUw6460renrN5lJhb6KqZH+3Cd/HLYg7qF/ZTMn
 Vv1RPuhgespFm+cgnjGatEk3VTGHTs7CWANTAiJ6T5a5mcjj3b2YEEKd0PaV4n5LY
 OKfLsJHHC+5FgnTEYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUosT-1ujbZy2BPt-00RY9Y; Fri, 17
 Oct 2025 16:18:11 +0200
Message-ID: <8b15b3e6-3f66-4e2b-9c77-7484bdd2b0d1@gmx.de>
Date: Fri, 17 Oct 2025 16:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] doc: make pdfdocs: Ensure SVG files are converted
 to PDF before the compilation of *.tex files
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
References: <20251005221057.255029-1-adrianocarvalho.pt@gmail.com>
 <20251005221057.255029-5-adrianocarvalho.pt@gmail.com>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>, Dhruva Gole <d-gole@ti.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Wadim Egorov <w.egorov@phytec.de>, Vitor Soares <vitor.soares@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, E Shattow <e@freeshell.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 open list <u-boot@lists.denx.de>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251005221057.255029-5-adrianocarvalho.pt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pu+83KJfnET5hBtLVMcUyML47lgHIBbEnL07Fodv5H8hkAGAXOv
 gLP2CU0VaT3wh75l2x0vyj9pGIdu2VdgTjJECL3Zq5zPFQc13RYmJxFYWEXdQCwQMhAmz0E
 wt51O3aoLxenRPmidxr7YkBkr1LRp3JVlGs2h79+FBsTeEu7CcN33DBZHQTNPNbCJP5m7aS
 XLafV0JDmIdQdpaNH1gzg==
UI-OutboundReport: notjunk:1;M01:P0:716fb/raWNU=;uHMQS7LxJ6C72zgi7XC/OEbo/KD
 PfFL+pavY0ycpxJtKB1oZlTe+dQCNmrHIP7Tb+PpV/fItwzxQqh/qQ6nhfhahqCEDcgqfyH2L
 FyBNx+JzdmEkbXZ8veUhyWQx5pTJP9NaPjFu7T44XwMpnizPBtu/FDxLsQym9ngQspjRdM7gu
 qowBnwVDTCMtnHSRyDLgOZ5gvRB0oyXSTSAn1NE5cdXIWNBfE12G+n33ABAUlhvz7eyey6wWD
 +DxkS3oawv72FAccWqhuUkbvbslZFBUigkPXLw0mgCvPcXzKj8Lr5CYyEDdVuA6oggibnFSKf
 F9sXmHwUSOpy2UbzlmVoxXni40bZdrFJ6WWS6DUJjLcyPNKb+Ib0K18wAafMNFDCpSLb9Dfpe
 6TJsYpTPCVJtGAk+abq/xow4cEQhu5GfYUqgjxNhVQD0EFL8+hYyeHagUn1fohG6b0GjqIOfU
 ZFPwCaSuog1m1DPJoajmLfaZ/dyRedtW5UfDJ7YUUwlo9tlysiliml3ITNUrPTDCgxGm4JWZi
 rS15GK3NGqpXdKySKLt9jyxoFh6YqoROFejCsrqylF6JNLs/5AsmBOiz3zmzYkjJrYv4ol8E+
 Hs9trBvz5vL2KbEUBiLjgNUn5PVbWz4VyobL0HZWz+Rq3Qo2RdmcQ6q4oFqgg+0/b4VQgtxtn
 ymKAL6KO013bSa7yhJjDj8m1HloCVO+F6Wl7NLoCsRIzV6JSieU63TCoVhTCuRzKFjZ/uz22t
 BQ/c6mat0hj27u7seP/oHdL68pqY+SAPwWUWYOg9o7KjweyPekKDAVa2tg2Dqj0qqbZKCBUjB
 vZvYlw2OIiP7NHWtg5EFXya3JAefmn5rsXTMN4zoMPg/DaLZfzb+ehTZ9aBRVPtdEeE3E8SXt
 beAOvnH7V4iBy9+/gGrYi/pTErxG0UUSQ0bpiqpeSa/XE6Ksu9vPcLvk6pMKOhUfG50j4PFQL
 lNR3MgbsZ6LmsFL1kDOJvQhTk6xW3FjLjRbFxmpDQMaJapDk/3qElMs97cohhACJ5inj1DUKm
 59WzQVjvhgc+ahx99W6/sAsSxnvZlQQBazZ9NYjuEhMI7B8iWHMYKgbksxvGXD7VJtReuy6M2
 duIdrN21auYWDK6hO2bkVJc813CtgrMOsPgg9CDF0/60WqqaCqskNNOUxqfJPctpuaR7pQFCe
 R6wPY+kek6QG7WXr8g2dPCFAzNfQUw8hskVcijF492+mp9r5hZYZWLS1a4DtS3yVdLtzwVdUw
 gCdjr54j7n7dnUKLRkfR6/0yuEedZQ6Dh4nk/IY5stq563HeAE2x/BesJoxY+RYOt6ydZVFNI
 YLfvKPKSQ4St9HjAjDIEY9uY+1GkGz7jGTq8ne7c+txbqUzXkPQyw3Mpy6Y3vSJtZ/YQo1x5Q
 pR9pAUlNotGG8O3W48tepoYqtlx3u1Qcwq0PFkWeiL2y0UIa34G5gKdIiW8g2FV8AcWwJOReN
 5c4Y8u7MXDIg+Cs17jmlGQYdIf+r+lAWqvYI7f4PLI/2tH+h/bOdfA2aWPWsyJ2oSCgoZWYx9
 lzyMBfh+yGAP7JjdKLjH4W+EJaX3e7tgNBJLGfSJmP9qXYeSvDpFFyPdSmCzrp2WyL9xRhvOv
 ms7IWag7BK/mLHbbip5P8fCe1OmlVdYKOih6tb6pn1ZERNpm5bdO1AEKb26YDJwV+2CXUN2vk
 qikreuqE8IFMt8J1N1gVMsvNjUpAvoBOWBGYQqmfBOEd02DwM00N5Zcemw46BiU1BdgXso49H
 crVRR4WAsiDpWQKtZCDln6J/4v4Pcm6Wim+0hCcHyjrWB9WNhjFndDDx+nEx/SkTaqlC9+eRZ
 lqbS7n4c4dTxGSIfNAHEFDX4yecXQo9f1neIMGVmYQaqIYlmXaGKoul4iK/xPT6F2/87Laj0T
 1GxXtvjgQKOGtoZSlDbqInAE/q1FyUfEXl88G0HHat96Igfx68OL2g8eChimtH1dsyCCTxuV1
 N+yDtzI+eaLrRa9lPoX4yH1zH8LS+ZB/rWXKNXePA36G7+vFdkAtW4TIOGjF0NqT28gwLF+u0
 r0L4BVs/mYJ+1KugQrYuyumWIpbEqgNEHVdwJaiLmfMq35I5N3ggEw3sk/zfgfJFogAvIOtwv
 OdbKna/w0QLhMyShayHEwOjzRpPj8nLQ8mWNdXuwDGuVdM6cEEqtrczdTY6MDR1y1NaAaDg8g
 +xGpYsgrzkmZLL/eq+hx78n6JhOK+MXOiosMF4eK13JLe1yV9nalCYp6uNseLZPBD5YriVmny
 pDp/FD95uBgzmwGojnYqfpPwYURkN/n/VxqWNEnBz4dTJDrbgNvX9c1PYRxm32DVDKTnHGkaY
 na7G+tyXomWRZQdYY1/e+BfLmnVBQqHPQ28xcZKYc9t4nFNz4hkq/kvMKHxo4xlvBikVFzG2D
 gN2dIv26LrawThs3gBKO3Ko+DM/NO8Jq2YTeUYDfum+/IuYwIGJlD/IF2Z5sbbbGS1BfxFQbT
 0OeU482TPewvuGAPflMPK4CDz/0170YXc2h85n5HofIhpDf7DDo4wAMkx377rv6hPyYi051XA
 n6fMGSAfcwPs0E6TZ5HvOBaddI3c3p7/nFTzk9YsGLRnWjsC1JUkC83F/8tw7JrBk6ka5uq9/
 NQdQNwH+xHkE6K+XylAXC5Oeok3qWaXITrHdBAyDP8v+imvjjK2XJlNN1m3kP8edqK7XjisNK
 aX+5FRCYED/jxHHaHBBTkd407A6ejTJnAIP4cJBo3tTDcTKJyg0KrNV+uwdgsInuPqWq4H/Tk
 U0Oshzb5143JTeAYuHdeeA6Y3Pmo7nYfDYNV942xhlODcSYcueK0tD5JUTIm6ft9ETHCU/J4d
 vwiaG1bGx/9xajTJx6mHSYhsCNWOb0o0AoeRU/oHyiZy046suqgVurgNa/w+PenNqMxTz1YkX
 g4hHlYjZojTxkF6DofGmFqDdAOzFFO5GG4zNCfg0/7CzxzcAmGJMGcuhbOcxseD5t7XMKAWzh
 DUCNmrvpzZnZCM1bZgt9I85SXYbmumyvwBRNy0AVFDGwPsC4RnFD63WoQ7zPzqPjqsHfTnxEL
 l3UKsJq9RGfi9APTWwsX9871l3BLEtNQYf5qwkeiuakmvvjwfiJYgdLXVi2jyDsl+JLmqqYCz
 aleQ4RKkfsTP62Bs4ZigaSnKXuCyvmW8/cEqqPpaFogdJi6VSN/1NRthZpbo/NHBRdTeV62bI
 Tne7IUnXMX0lhze07Gx2I3QkKFOkTk3VSBZEPALsjZvNQOvaomo0KOLygEaHlU2FxMM667GbG
 Y5+gYxRYpbZb85m4A/sJU3l8Byx6d9RRxLu/Ou3YMcjqVE/E57RClz7BqLY+o6/up3333DGLo
 qKtOPxRKucNMPklCvrhvTrK8spNZEiteftx6OVf3ivFS/GL3uaXwBLdjlxNlqEK9wp0xK819z
 t+NVJuqlKL3e5wvmBIZx05FTMHTNICmTaDV1OhudaBICWQWRCSAuU4rgRGP1k6EHVyGNE2Vq6
 Q0kstiIc4ht+nj+89zF9mQeUF4IePt9pr4xEqZASCD8O2Xb1B9KlJ5RxP60hRAqK/Epf+83c+
 699il61Vo+RGb8Z7N0C+Dr0XlcgHYpBeR4vaXM5MJc1kPzrcAk3UbS0aZlyDhgwxVie74j0WH
 XZpSbje93Cd8iPP3ostPV23e+YTLeEGeQO9Ad3WEwFxazqoSZpIpPb0R3dvpuKHtKTQwxzraQ
 aJcly9hRAUWhAgigaJtHs5+CB/gO79OriY0w9dSkjmWUZ+KIRjtbKwCxPwKaOLmejusMF/T8L
 1hZBOYFpKARs7M57yC4cTxcJxbOf3yYZhtDVYnRX4XoTTNm+T2CrOIzGbqam4MNOU0qk7YbHs
 /GO8JIWjlbiGoS6nJbQn4KPMBCs1X7de916PB1lIaDmsMWYD8I9/8xiiilTvl5okphConn/Zz
 e/OHgdV5pjdzlB6cWABRYeDardcbwXl9okoE07dgjImvJokCUqNl4xEk8FvZxpPZ6nM7oFaEm
 KaCCYj39oNzZxRrV5tp1nAQaAQjwHqvvtSLVtVuikVTazoP3+BE215le3koSTvGCFfiZl7Fa9
 VPw95DtU29/CmREKXh2xscXMFE4Jx1VPuIYK4bmZx96wUdC17d1YjoPgh9ai6gOLPFa5B3201
 vXA3+B6XvP0P08lLja1FPC2NKIzqq2K42xlShDg9YsbLen0+t2gAF5o3NfQzxEABNZbWpGk73
 z1/ifiDhV7c6fhlAscOOiyywimiSG4867n8XNi7TmuRC9vOhnxuE4qHHbTsr1q7eV9P+kWeK+
 cWrBGMBCBgRrKLXL6/RrXCQWvvRBdALah278ebEAcuFbAFtWnSEBoS+BchNGDgyakr5bcn2h8
 +HNzx0e2WjxKnav0Gz3x5zFldS7m6NfrvehTzC7yPqF1lG0P86UqHS5AsISIiGHGaq4hRDbtR
 UcJSKJl1v798z0YxttLxEJ331g7QiKOkCPZGwwoltebiW20EVKWJAMAnOHu9lYxNL5RtmnTuZ
 sytYo2woHWXjP3SmzWouPNIU7Sew+cOhMfvQGVvtIlaqF8QR0WD16DsuX6yQp7s+oLEj/D7yF
 gv0P4uL6JESe+bAchMwhb39qNBNDt4WQ8eJv0h5xVNSzpalmbiks2FaMTn7i7Ok/2IWCBNqPD
 4LCFuGuY4ADqqOONPU/Qrlx1Ybur/dVjhezF3l48me3zkOOjrO39/YqqBNlOQwpWQ464+cRdi
 Q2kLJfe92tffKwcDEUSNwnhKO10HrS4troQhp78GueJgrLiZfIiWk9NDzhSX0Z9jSvqW0G5Lm
 EEoUJd+FWqP0CQ3pRBKmbT8hBITgJAIRRdL2LXKWN41H8fK/iOY4kxXfITJqpZkZ4PiRQLzjK
 g3Edy5Q8WAflm4qyyLracwC3/46zTfLd0iUdaDVLXF42+2BOmXodX+cVP4ThS3QCctGdjNP3s
 uN+w22tU2ZEFALbwZzKbefbXE6jtgDddC9EaySCYQLMXqRJlTGljrHeIWe2UjghVyHRqmHuW+
 c2M8KXE7ETw3+pTwGHxRHD9Y5qlx4dj2GqCXEKLcbeqDZ091mQ7BSqCfyqRr6PMS/YFd3OV3M
 dZidpk3VAr0ePnLyMf12qpjgLDgcfYvPN2r4hjm1PmdsJuotvHKILrlz/w947Euh9eQlgD9SK
 vClWsBXhsd46iDA0KC8IS4FYLhw3kjCGvj6JPsJM4TvIfja16G3dYqzdYNkOvNxO2eNvcbIIh
 Q2KLrenw=
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

On 10/6/25 00:10, Adriano Carvalho wrote:
> SVG files are not handled directly in the *.tex files. This commit
> replaces all instances of ".. image::" with ".. kernel-figure::". With
> this, the kfigure sphinx extension (already present) ensures that SVG
> files are converted to PDF before the compilation of *.tex files.
>=20
> If I don't do this, this is what I get with
> docker.io/trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
> [...]
> xelatex  'android.tex'
> [...]
> Output written on android.pdf (28 pages).
> [...]
> xelatex  'api.tex'
> [...]
> Output written on api.pdf (431 pages).
> [...]
> xelatex  'arch.tex'
> [...]
> Output written on arch.pdf (62 pages).
> [...]
> xelatex  'board.tex'
> [...]
>=20
> [152]
> Chapter 14.
>=20
> ! LaTeX Error: Cannot determine size of graphic in boot_diagram_am62.svg=
 (no Bo
> undingBox).
>=20
> See the LaTeX manual or LaTeX Companion for explanation.
> Type  H <return>  for immediate help.
>   ...
>=20
> l.11422 ...ncludegraphics{{boot_diagram_am62}.svg}
>=20
> ?
> ! Emergency stop.
>   ...
>=20
> [...]
>=20
> Output written on board.pdf (156 pages).
> Transcript written on board.log.
> make[2]: *** [Makefile:29: board.pdf] Error 1
> make[1]: *** [doc/Makefile:95: pdfdocs] Error 2
> make: *** [Makefile:2687: pdfdocs] Error 2
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Please, describe the usage of kernel-figure in doc/develop/docstyle.rst=20
so that documentation maintainers know when to use it.

Best regards

Heinrich

> ---
>   doc/board/beagle/am62x_beagleplay.rst     |  8 ++++----
>   doc/board/beagle/am67a_beagley_ai.rst     |  6 +++---
>   doc/board/beagle/j721e_beagleboneai64.rst | 10 +++++-----
>   doc/board/samsung/e850-96.rst             |  2 +-
>   doc/board/ti/am62ax_sk.rst                |  6 +++---
>   doc/board/ti/am62px_sk.rst                |  8 ++++----
>   doc/board/ti/am62x_sk.rst                 |  8 ++++----
>   doc/board/ti/am64x_evm.rst                |  8 ++++----
>   doc/board/ti/am65x_evm.rst                | 12 ++++++------
>   doc/board/ti/j7200_evm.rst                | 10 +++++-----
>   doc/board/ti/j721e_evm.rst                | 10 +++++-----
>   doc/board/ti/j721s2_evm.rst               |  6 +++---
>   doc/board/ti/j722s_evm.rst                |  6 +++---
>   doc/board/ti/j784s4_evm.rst               |  8 ++++----
>   doc/board/ti/k3.rst                       |  8 ++++----
>   doc/develop/memory.rst                    |  4 ++--
>   doc/develop/trace.rst                     | 10 +++++-----
>   tools/patman/patman.rst                   |  2 +-
>   18 files changed, 66 insertions(+), 66 deletions(-)
>=20
> diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am=
62x_beagleplay.rst
> index bc71aabaac3..8188f0b41c9 100644
> --- a/doc/board/beagle/am62x_beagleplay.rst
> +++ b/doc/board/beagle/am62x_beagleplay.rst
> @@ -23,7 +23,7 @@ Boot Flow:
>   ----------
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: ../ti/img/boot_diagram_am62.svg
> +.. kernel-figure:: ../ti/img/boot_diagram_am62.svg
>     :alt: Boot flow diagram
>  =20
>   - On this platform, 'TI Foundational Security' (TIFS) functions as the
> @@ -85,12 +85,12 @@ Image formats
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: ../ti/img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: ../ti/img/multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
> +.. kernel-figure:: ../ti/img/tifsstub_dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   Additional hardware for U-Boot development
> @@ -172,7 +172,7 @@ Area (UDA) hardware partition of the eMMC. These com=
ponents can vary
>   significantly in size. The choice of keeping tiboot3.bin in boot0 or
>   boot1 partition depends on A/B update requirements.
>  =20
> -.. image:: img/beagleplay_emmc.svg
> +.. kernel-figure:: img/beagleplay_emmc.svg
>     :alt: eMMC partitions and boot file organization for BeaglePlay
>  =20
>   The following are the steps from Linux shell to program eMMC:
> diff --git a/doc/board/beagle/am67a_beagley_ai.rst b/doc/board/beagle/am=
67a_beagley_ai.rst
> index 3d2fc4a3195..7113029f0ff 100644
> --- a/doc/board/beagle/am67a_beagley_ai.rst
> +++ b/doc/board/beagle/am67a_beagley_ai.rst
> @@ -23,7 +23,7 @@ Boot Flow:
>   ----------
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: ../ti/img/boot_diagram_k3_current.svg
> +.. kernel-figure:: ../ti/img/boot_diagram_k3_current.svg
>     :alt: Boot flow diagram
>  =20
>   - On this platform, 'TI Foundational Security' (TIFS) functions as the
> @@ -84,12 +84,12 @@ Image formats
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: ../ti/img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: ../ti/img/multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
> +.. kernel-figure:: ../ti/img/tifsstub_dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   Additional hardware for U-Boot development
> diff --git a/doc/board/beagle/j721e_beagleboneai64.rst b/doc/board/beagl=
e/j721e_beagleboneai64.rst
> index a57bc743569..94bcce75a42 100644
> --- a/doc/board/beagle/j721e_beagleboneai64.rst
> +++ b/doc/board/beagle/j721e_beagleboneai64.rst
> @@ -26,7 +26,7 @@ Boot Flow:
>   ----------
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: ../ti/img/boot_diagram_j721e.svg
> +.. kernel-figure:: ../ti/img/boot_diagram_j721e.svg
>     :alt: Boot flow diagram
>  =20
>   - On this platform, DMSC runs 'TI Foundational Security' (TIFS) which
> @@ -92,17 +92,17 @@ Image formats
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: ../ti/img/no_multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: ../ti/img/no_multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: ../ti/img/dm_tispl.bin.svg
> +.. kernel-figure:: ../ti/img/dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   - sysfw.itb
>  =20
> -.. image:: ../ti/img/sysfw.itb.svg
> +.. kernel-figure:: ../ti/img/sysfw.itb.svg
>     :alt: sysfw.itb image format
>  =20
>   Additional hardware for U-Boot development
> @@ -184,7 +184,7 @@ Area (UDA) hardware partition of the eMMC. These com=
ponents can vary
>   significantly in size. The choice of keeping tiboot3.bin in boot0 or
>   boot1 partition depends on A/B update requirements.
>  =20
> -.. image:: img/beagleplay_emmc.svg
> +.. kernel-figure:: img/beagleplay_emmc.svg
>     :alt: eMMC partitions and boot file organization for BeagleBone AI-6=
4
>  =20
>   The following are the steps from Linux shell to program eMMC:
> diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.r=
st
> index b435fa8b353..8e47dcbf5b6 100644
> --- a/doc/board/samsung/e850-96.rst
> +++ b/doc/board/samsung/e850-96.rst
> @@ -28,7 +28,7 @@ Boot Flow
>  =20
>   The boot path for Exynos850 is shown on the figure below.
>  =20
> -.. image:: img/exynos850-boot-architecture.svg
> +.. kernel-figure:: img/exynos850-boot-architecture.svg
>     :alt: Exynos850 SoC boot flow
>  =20
>   Legend:
> diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
> index 4dd998bcce9..8a45453c1a8 100644
> --- a/doc/board/ti/am62ax_sk.rst
> +++ b/doc/board/ti/am62ax_sk.rst
> @@ -47,7 +47,7 @@ Boot Flow:
>   ----------
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: img/boot_diagram_am62.svg
> +.. kernel-figure:: img/boot_diagram_am62.svg
>     :alt: Boot flow diagram
>  =20
>   - Here TIFS acts as master and provides all the critical services. R5/=
A53
> @@ -138,12 +138,12 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/tifsstub_dm_tispl.bin.svg
> +.. kernel-figure:: img/tifsstub_dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   Switch Setting for Boot Mode
> diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> index a07d6a4da45..dc54a47dbb4 100644
> --- a/doc/board/ti/am62px_sk.rst
> +++ b/doc/board/ti/am62px_sk.rst
> @@ -55,7 +55,7 @@ Boot Flow:
>   The bootflow is exactly the same as all SoCs in the am62xxx extended S=
oC
>   family. Below is the pictorial representation:
>  =20
> -.. image:: img/boot_diagram_am62.svg
> +.. kernel-figure:: img/boot_diagram_am62.svg
>     :alt: Boot flow diagram
>  =20
>   - Here TIFS acts as master and provides all the critical services. R5/=
A53
> @@ -152,12 +152,12 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/tifsstub_dm_tispl.bin.svg
> +.. kernel-figure:: img/tifsstub_dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   OSPI:
> @@ -181,7 +181,7 @@ over tftp and then flash those to OSPI at their resp=
ective addresses.
>  =20
>   Flash layout for OSPI:
>  =20
> -.. image:: img/ospi_sysfw2.svg
> +.. kernel-figure:: img/ospi_sysfw2.svg
>     :alt: OSPI flash partition layout
>  =20
>   A53 SPL DDR Memory Layout
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index dab2970a85c..4ca668dfeab 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -46,7 +46,7 @@ Boot Flow:
>   ----------
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: img/boot_diagram_am62.svg
> +.. kernel-figure:: img/boot_diagram_am62.svg
>     :alt: Boot flow diagram
>  =20
>   - Here TIFS acts as master and provides all the critical services. R5/=
A53
> @@ -174,12 +174,12 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/tifsstub_dm_tispl.bin.svg
> +.. kernel-figure:: img/tifsstub_dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   OSPI:
> @@ -203,7 +203,7 @@ over tftp and then flash those to OSPI at their resp=
ective addresses.
>  =20
>   Flash layout for OSPI:
>  =20
> -.. image:: img/ospi_sysfw2.svg
> +.. kernel-figure:: img/ospi_sysfw2.svg
>     :alt: OSPI flash partition layout
>  =20
>   A53 SPL DDR Memory Layout
> diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> index 65c4c456528..015b8cfb299 100644
> --- a/doc/board/ti/am64x_evm.rst
> +++ b/doc/board/ti/am64x_evm.rst
> @@ -35,7 +35,7 @@ Boot Flow:
>   ----------
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: img/boot_diagram_am64.svg
> +.. kernel-figure:: img/boot_diagram_am64.svg
>     :alt: Boot flow diagram
>  =20
>   - Here TIFS acts as master and provides all the critical services. R5/=
A53
> @@ -136,12 +136,12 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/nodm_tispl.bin.svg
> +.. kernel-figure:: img/nodm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   OSPI:
> @@ -165,7 +165,7 @@ over tftp and then flash those to OSPI at their resp=
ective addresses.
>  =20
>   Flash layout for OSPI:
>  =20
> -.. image:: img/ospi_sysfw-am64.svg
> +.. kernel-figure:: img/ospi_sysfw-am64.svg
>     :alt: OSPI flash partition layout
>  =20
>   Switch Setting for Boot Mode
> diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
> index 60b08ceebf0..7be4c6eaf44 100644
> --- a/doc/board/ti/am65x_evm.rst
> +++ b/doc/board/ti/am65x_evm.rst
> @@ -45,7 +45,7 @@ applications. This should happen before running Linux.
>   3. In production boot flow, we might not like to use full U-Boot,
>   instead use Falcon boot flow to reduce boot time.
>  =20
> -.. image:: img/boot_diagram_am65.svg
> +.. kernel-figure:: img/boot_diagram_am65.svg
>     :alt: Boot flow diagram
>  =20
>   - Here DMSC acts as master and provides all the critical services. R5/=
A53
> @@ -141,17 +141,17 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/no_multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/no_multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/nodm_tispl.bin.svg
> +.. kernel-figure:: img/nodm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   - sysfw.itb
>  =20
> -.. image:: img/sysfw.itb.svg
> +.. kernel-figure:: img/sysfw.itb.svg
>     :alt: sysfw.itb image format
>  =20
>   eMMC:
> @@ -193,7 +193,7 @@ used:
>  =20
>   eMMC layout:
>  =20
> -.. image:: img/emmc_am65x_evm_boot0.svg
> +.. kernel-figure:: img/emmc_am65x_evm_boot0.svg
>     :alt: emmc boot partition layout
>  =20
>   Kernel image and DT are expected to be present in the /boot folder of =
rootfs.
> @@ -229,7 +229,7 @@ addresses.
>  =20
>   Flash layout for OSPI:
>  =20
> -.. image:: img/ospi_sysfw.svg
> +.. kernel-figure:: img/ospi_sysfw.svg
>     :alt: OSPI flash partition layout
>  =20
>   Kernel Image and DT are expected to be present in the /boot folder of =
UBIFS
> diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
> index 4fd2aff8354..b6e285ec621 100644
> --- a/doc/board/ti/j7200_evm.rst
> +++ b/doc/board/ti/j7200_evm.rst
> @@ -34,7 +34,7 @@ Boot Flow:
>   ----------
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: img/boot_diagram_k3_current.svg
> +.. kernel-figure:: img/boot_diagram_k3_current.svg
>     :alt: Boot flow diagram
>  =20
>   - Here DMSC acts as master and provides all the critical services. R5/=
A72
> @@ -135,12 +135,12 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/j7200_tiboot3.bin.svg
> +.. kernel-figure:: img/j7200_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/dm_tispl.bin.svg
> +.. kernel-figure:: img/dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   Switch Setting for Boot Mode
> @@ -196,7 +196,7 @@ Current allocated size for tiboot3 size is 1MB, tisp=
l is 2MB.
>   Size of u-boot.img is taken 4MB for refernece,
>   But this is subject to change depending upon atf, optee size
>  =20
> -.. image:: img/emmc_j7200_evm_boot01.svg
> +.. kernel-figure:: img/emmc_j7200_evm_boot01.svg
>     :alt: Traditional eMMC boot partition layout
>  =20
>   In case of UDA FS mode booting, following is layout.
> @@ -204,7 +204,7 @@ In case of UDA FS mode booting, following is layout.
>   All boot images tiboot3.bin, tispl and u-boot should be written to
>   fat formatted UDA FS as file.
>  =20
> -.. image:: img/emmc_j7200_evm_udafs.svg
> +.. kernel-figure:: img/emmc_j7200_evm_udafs.svg
>     :alt: eMMC UDA boot partition layout
>  =20
>   In case of booting from eMMC, write above images into raw or UDA FS.
> diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
> index 41c8d4c72a8..75994de8b60 100644
> --- a/doc/board/ti/j721e_evm.rst
> +++ b/doc/board/ti/j721e_evm.rst
> @@ -39,7 +39,7 @@ Boot Flow:
>   Boot flow is similar to that of AM65x SoC and extending it with remote=
proc
>   support. Below is the pictorial representation of boot flow:
>  =20
> -.. image:: img/boot_diagram_j721e.svg
> +.. kernel-figure:: img/boot_diagram_j721e.svg
>     :alt: Boot flow diagram
>  =20
>   - Here DMSC acts as master and provides all the critical services. R5/=
A72
> @@ -141,17 +141,17 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/no_multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/no_multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/dm_tispl.bin.svg
> +.. kernel-figure:: img/dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   - sysfw.itb
>  =20
> -.. image:: img/sysfw.itb.svg
> +.. kernel-figure:: img/sysfw.itb.svg
>     :alt: sysfw.itb image format
>  =20
>   OSPI:
> @@ -178,7 +178,7 @@ addresses.
>  =20
>   Flash layout for OSPI:
>  =20
> -.. image:: img/ospi_sysfw.svg
> +.. kernel-figure:: img/ospi_sysfw.svg
>     :alt: OSPI flash partition layout
>  =20
>   R5 Memory Map:
> diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
> index 21683b90b1a..1257c5a3ae9 100644
> --- a/doc/board/ti/j721s2_evm.rst
> +++ b/doc/board/ti/j721s2_evm.rst
> @@ -42,7 +42,7 @@ Boot Flow:
>  =20
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: img/boot_diagram_k3_current.svg
> +.. kernel-figure:: img/boot_diagram_k3_current.svg
>  =20
>   - On this platform, "TI Foundational Security" (TIFS) functions as the
>     security enclave master while "Device Manager" (DM), also known as t=
he
> @@ -152,11 +152,11 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/dm_tispl.bin.svg
> +.. kernel-figure:: img/dm_tispl.bin.svg
>  =20
>   R5 Memory Map:
>   --------------
> diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
> index 9c53fa50858..ec3254d9ae7 100644
> --- a/doc/board/ti/j722s_evm.rst
> +++ b/doc/board/ti/j722s_evm.rst
> @@ -32,7 +32,7 @@ Boot Flow:
>   The bootflow is exactly the same as all SoCs in the am62xxx extended S=
oC
>   family. Below is the pictorial representation:
>  =20
> -.. image:: img/boot_diagram_k3_current.svg
> +.. kernel-figure:: img/boot_diagram_k3_current.svg
>     :alt: Boot flow diagram
>  =20
>   - Here TIFS acts as master and provides all the critical services. R5/=
A53
> @@ -126,12 +126,12 @@ Image formats:
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
>     :alt: tiboot3.bin image format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/dm_tispl.bin.svg
> +.. kernel-figure:: img/dm_tispl.bin.svg
>     :alt: tispl.bin image format
>  =20
>   A53 SPL DDR Memory Layout
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index 22442874110..a6bb11b9a91 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -41,7 +41,7 @@ Boot Flow
>   ---------
>   Below is the pictorial representation of boot flow:
>  =20
> -.. image:: img/boot_diagram_k3_current.svg
> +.. kernel-figure:: img/boot_diagram_k3_current.svg
>       :alt: K3 boot flow
>  =20
>   - On this platform, "TI Foundational Security" (TIFS) functions as the
> @@ -158,12 +158,12 @@ Image formats
>  =20
>   - tiboot3.bin
>  =20
> -.. image:: img/multi_cert_tiboot3.bin.svg
> +.. kernel-figure:: img/multi_cert_tiboot3.bin.svg
>       :alt: tiboot3.bin format
>  =20
>   - tispl.bin
>  =20
> -.. image:: img/dm_tispl.bin.svg
> +.. kernel-figure:: img/dm_tispl.bin.svg
>       :alt: tispl.bin format
>  =20
>   OSPI:
> @@ -188,7 +188,7 @@ addresses.
>  =20
>   Flash layout for OSPI NOR:
>  =20
> -.. image:: img/ospi_sysfw3.svg
> +.. kernel-figure:: img/ospi_sysfw3.svg
>     :alt: OSPI NOR flash partition layout
>  =20
>   R5 Memory Map
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 01fb9411688..0b9a91bf6fa 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -61,7 +61,7 @@ boot media needed to load the binaries packaged inside=
 `tiboot3.bin`,
>   including a 32bit U-Boot SPL, (called the wakeup SPL) that ROM will ju=
mp
>   to after it has finished loading everything into internal SRAM.
>  =20
> -.. image:: img/boot_flow_01.svg
> +.. kernel-figure:: img/boot_flow_01.svg
>     :alt: Boot flow up to wakeup domain SPL
>  =20
>   The wakeup SPL, running on a wakeup domain core, will initialize DDR a=
nd
> @@ -71,7 +71,7 @@ application cores inside the main domain to initialize=
 the main domain,
>   starting with Trusted Firmware-A (TF-A), before moving on to start
>   OP-TEE and the main domain's U-Boot SPL.
>  =20
> -.. image:: img/boot_flow_02.svg
> +.. kernel-figure:: img/boot_flow_02.svg
>     :alt: Boot flow up to main domain SPL
>  =20
>   The main domain's SPL, running on a 64bit application core, has
> @@ -80,7 +80,7 @@ initialize even more peripherals needed to load in the=
 `u-boot.img`
>   which loads more firmware into the micro-controller & wakeup domains a=
nd
>   finally prepare the main domain to run Linux.
>  =20
> -.. image:: img/boot_flow_03.svg
> +.. kernel-figure:: img/boot_flow_03.svg
>     :alt: Complete boot flow up to Linux
>  =20
>   This is the typical boot flow for all K3 based SoCs, however this flow
> @@ -691,7 +691,7 @@ generation device.
>  =20
>   The overall structure of this setup is in the following figure.
>  =20
> -.. image:: img/openocd-overview.svg
> +.. kernel-figure:: img/openocd-overview.svg
>     :alt: Overview of OpenOCD setup.
>  =20
>   .. note::
> diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
> index 5177229630d..d7f842f3367 100644
> --- a/doc/develop/memory.rst
> +++ b/doc/develop/memory.rst
> @@ -69,7 +69,7 @@ SPL Flow
>         Prior to setting up of the DRAM, the stack, malloc is defined as=
 below
>         possibly sitting on a smaller readily available memory (SRAM etc=
.):
>  =20
> -      .. image:: pics/spl_before_reloc.svg
> +      .. kernel-figure:: pics/spl_before_reloc.svg
>            :alt: contents of ready RAM before relocation in SPL
>  =20
>         Please see CONFIG_SPL_EARLY_BSS if BSS initialization is needed =
prior
> @@ -95,7 +95,7 @@ SPL Flow
>  =20
>         The final environment is setup and the system RAM now looks like=
 this:
>  =20
> -      .. image:: pics/spl_after_reloc.svg
> +      .. kernel-figure:: pics/spl_after_reloc.svg
>            :alt: contents of DRAM after relocation in SPL
>  =20
>         Again stack and gd are an optional move and may still remain in =
the
> diff --git a/doc/develop/trace.rst b/doc/develop/trace.rst
> index d3c8628d124..417f138fea2 100644
> --- a/doc/develop/trace.rst
> +++ b/doc/develop/trace.rst
> @@ -111,7 +111,7 @@ Finally run kernelshark to display it (note it only =
works with `.dat` files!):
>   Using this tool you can view the trace records and see the timestamp f=
or each
>   function.
>  =20
> -.. image:: pics/kernelshark.png
> +.. kernel-figure:: pics/kernelshark.png
>     :width: 800
>     :alt: Kernelshark showing function-trace records
>  =20
> @@ -144,7 +144,7 @@ There is a -f option available to select a function =
graph:
>   Again, you can use kernelshark or trace-cmd to look at the output. In =
this case
>   you will see the time taken by each function shown against its exit re=
cord.
>  =20
> -.. image:: pics/kernelshark_fg.png
> +.. kernel-figure:: pics/kernelshark_fg.png
>     :width: 800
>     :alt: Kernelshark showing function-graph records
>  =20
> @@ -188,11 +188,11 @@ command:
>   You can load the .svg file into a viewer. If you use Chrome (and some =
other
>   programs) you can click around and zoom in and out.
>  =20
> -.. image:: pics/flamegraph.png
> +.. kernel-figure:: pics/flamegraph.png
>     :width: 800
>     :alt: Chrome showing the flamegraph.pl output
>  =20
> -.. image:: pics/flamegraph_zoom.png
> +.. kernel-figure:: pics/flamegraph_zoom.png
>     :width: 800
>     :alt: Chrome showing zooming into the flamegraph.pl output
>  =20
> @@ -209,7 +209,7 @@ Note that trace collection does slow down execution =
so the timings will be
>   inflated. They should be used to guide optimisation. For accurate boot=
 timings,
>   use bootstage.
>  =20
> -.. image:: pics/flamegraph_timing.png
> +.. kernel-figure:: pics/flamegraph_timing.png
>     :width: 800
>     :alt: Chrome showing flamegraph.pl output with timing
>  =20
> diff --git a/tools/patman/patman.rst b/tools/patman/patman.rst
> index 549e203c254..44a97ac11a6 100644
> --- a/tools/patman/patman.rst
> +++ b/tools/patman/patman.rst
> @@ -932,7 +932,7 @@ be sure to check out the help.
>  =20
>   Here is a sample 'progress' view:
>  =20
> -.. image:: pics/patman.jpg
> +.. kernel-figure:: pics/patman.jpg
>     :width: 800
>     :alt: Patman showing the progress view
>  =20

