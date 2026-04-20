Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC86F5A8B8
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9A0844C3;
	Mon, 20 Apr 2026 22:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="tV7R/hD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2313843E0; Mon, 20 Apr 2026 22:27:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A970843AF
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 22:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776716823; x=1777321623; i=xypron.glpk@gmx.de;
 bh=9qtUMKQFeKQ42GCQ9iJiLXbHUhxtANzjQMUWDWswegE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=tV7R/hD1kkkkliOocVkSXILyxAxkRkIODoavg9pdM0qPgRjAqnJkMJFvvBSM47a2
 1mEb9ipTIvwJnc4UuRQpiTStXMkN9+YKzIF2ModiHYRkrMnl6woxo7Ra+RTAJuhAW
 4Ywq2iTXEI6NSRm2Jafg3D6cbD4+fg23UD0auC/sbbWyGaL0uOoWfCKQZESXhPyBV
 H+VeiPugXKBkAb79G7D7zYI4IkN97ZJd/iD9Z+VJ/HnaxRE1KmS6acTe03TKRKw9D
 U9TXzuRUzT3asKqStuPMUCWSJTIckulPUdQwzTdbmx5KClgLFKmJtIAIcYO8D71hL
 4Z6+qls4x+Nq+fJcfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbRm-1wB73g3sQo-003ahq; Mon, 20
 Apr 2026 22:27:03 +0200
Date: Mon, 20 Apr 2026 22:24:48 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 uboot-stm32@st-md-mailman.stormreply.com,
 Paul Barker <paul.barker.ct@bp.renesas.com>
CC: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Udit Kumar <u-kumar1@ti.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adam Ford <aford173@gmail.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>,
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Stefan Roese <sr@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Maarten Brock <Maarten.Brock@sttls.nl>,
 Kory Maincent <kory.maincent@bootlin.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Anshul Dalal <anshuld@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Martin Schwan <m.schwan@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 David Lechner <dlechner@baylibre.com>,
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, Beiyan Yun <root@infi.wang>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shantur Rathore <i@shantur.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Sky Huang <SkyLake.Huang@mediatek.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/6=5D_net=3A_make_NET_a_menuconfig?=
 =?US-ASCII?Q?_=28and_downgrade_NO=5FNET_to_a_simple_config=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260420-net-kconfig-v1-3-9900002d8e72@cherry.de>
References: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
 <20260420-net-kconfig-v1-3-9900002d8e72@cherry.de>
Message-ID: <18031190-2B66-4DEF-8382-6CB9DCCFA3A1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xHByMy9Ja4wdTxfxkuIBnccoTecaDz3eQULuxnvXVmoIcgQpsmd
 7thJp8H/tnPGq0PNPIlt1WCiMJIK74xXiKrLtGsTNIwniffaoAe35+oQ1KDjVZu6/TQcJe6
 ZjDODhEqqfNM2mB/FPfdMg4Ew6+dkpsz9+2oYhA423KbRbfgHYE+V8LemHKTC8i6KGmGHnm
 j5rkG8BFIAaHdl/lZBLCg==
UI-OutboundReport: notjunk:1;M01:P0:rZRGvyzcuMk=;yPyb4dnPCd9Pg/uFF842RBZVj1Z
 Jh7ZzKpwTpwAkr/s6zHg72ANH9x5ofUMktJybVN/5QsQsSa344rlfXHc1ltBareuR8yKEp8Ee
 x8cvVgaTaU7wAhyAkGmwswdPz5eIqFGZXC0OG3xO/KR3I+Cm/kvD9loeJxUAHg+ISFTog1e9X
 1Srre5hxMJU7NZ8BJy6ZnLvSMguBuAjqyLceeKQdyqvE/eT0uWtVu01CS7CRoqjv4Hs5Gsjj7
 2vII7KGKA3Wk+m6AR3/4z/o6yE4Ke7H+o19c0EiBzL0FW6mll0MtO0wo4O7MY4BZ7S7t6YpWc
 GQb9UkW2bVtkMvA0HzAxkFaBFgqmwTdUaTZXNW8BNsXlcxQvfXYibrSn8gpuY8/v+Ti8bh74U
 rHe/ZwyNg480x1EPDrFY4J3bvM1VQf8ycDia+e7LdkvO8zfhKzwLGMYjmJQpjXdaDQhZjrizz
 bnEbefN/gLsCzQEDlVOwgF1vGWjJ/B+vKxZ5Z5RAv0Ltz9UcerVYYdR8F7ZGhGi7KV2enzAl+
 IIgSrAGrTN3C/M54FZMu4z6mT1uZ3s3l1UlvNGxII90u9+dDTym01AFYM54SEUWayuBp2yd1H
 UmyYzukg2dmklLzfr11YZN0ldzl06bTgqlymknwnP9eAEaNyhnbpN7WVSYzFtE9dv+TjiKeoT
 L4O93gJliyURnvU3UPKsU/jcRhWad+BUHmnL3nGS5g93OjPvg9V2hhy583k5XG7bJKLTa5bkF
 NRtK7hFbMJ7xiBDTDfuz5UrarBynTmCS+tDJqRP+bNHzzSKq2qklh+JzdvrnY0HyUlZt6mBX/
 ZGTrZPgVzVER/ILFcnVEp7Z+I2tP0hxAa0Hp61MB1XjsG9FLwKqVqpu8nEt6/1e9CXx9k2VGg
 p91joOoXN88Be0fPSqO7oMbP52bSUZtY/z0OTKG689HMnZXs2KwUR1U7FZZzDW398LYW8ykES
 EOiMTYUW4v4o0Gh7+zejTpXojS+o/aLOlbrQxaQ1w+miXxD5pbXcUObj5Q9BSxah75W0aVGSS
 5xvtR309JMaEgCRGH2ORxOYOqNp0Epr4jaz4+OkAlI8hb7NYEd0cVhx9JqPEv6H4mQa3o0+vE
 87Q4yeJXWLDCF4FyNksjUrpsytuvfWewWwBHZLtT0QA0dXXltnz6uvcLCZR8+m8miOMvLowKw
 i6PiVn/Oga2Ih5ssih71Y09T9LZ5oP7/WZ6tVfOPa2Fs7PwrJCMCBKY0eygXey+e/GCHp381x
 QHXPxEqSWu8hU9X5ip9CJQupSuMAzaWiQo3EQxrOZ1hx3ZZDHL3sxmm1hFBvcYfOf7SjnmUX7
 tMnLwnpyTu/2j/ZprHJMnuKow5zt12R4MU2hwXTFU7LhyvBK2teyNFSdG0nt9NBP/aFu1TBP9
 xp1Rj5qeBq4IXJAn9cWSFDdkg+6Tg2s5401n9QHnzKmCYMeW7HNsLgKHrk4qP0y59bYqh1ZXT
 FOcrh/LeHXxWcwkPknPV1RnOUBb7vS5oyUwPLkm0KzZqNCs4vfKpOKVzEoFW31P7LTTEuoui2
 nepd+0MjCN0s3ZXcdmdMdoB8YowAcoZEblZP2WrYv5YtfNxo/DzUaqAbvEGEFACLkKjfalhWY
 gysYEBJq+E7Q5nuCCzshwurVK3svEAPlU4jx2ceuLj2XZRXKWuiWvU6rkmtoj6y/y712JU25j
 NDKK/nj5RxEFbZRHCwN0pcfxUEEn7jwOwZjaOmbts6yXO4IvcJDwK3ucu59tCfvMlK3Fphngv
 yYyJmOLh7MXhmfkCVr9aleNgUjHkpt9/wOjLEd8pF+8Za3Trp3oFLa8sz2cN3M74tcjb3tsMD
 MXaN2ogavwJmTrKKS8rlFn0v04G/wMlf0I5K7Fpk3uG6p1OJzNSl6dx5FD1YoTvlVte4UEBd4
 pBeW0ixvp+YVj8Sg9t9HMeWL79iKsD7KBl19fP9F/XJeEgPIEb6v4Lu3UXNjHzLI19h2xrN27
 pQvaYtbndldZYsZR7Crb+lycbBuv/S8nH3Cbvhg3rCRMAe1WIZl/PCWSy0zkGAjKKPespvAOa
 F77jHxeenYUsNCApTvyIXIcunFIiDsq36zBet3v5tFvWBBTvbosRv/Ojh0Hvf1AaN3EGluDg2
 5ANiW80+CM3LOLqKknu/aV9BCZqWSjqCV9FFqbUznVUYrhwanAYZ5zinD3mugiUNX6SsIO/w2
 Fdo/U0CyetIBxSF/gAweWYbSLhG0cMMC182dvWGRbnZ/dz/Okjg9hAGAK2aaXm/UrIvp/PD6p
 fJIsYyjkxylMjJ08GNGTeysCpXfgDp+IVdQrUJFLZMuBt3mkuJVbcckk8ncjILGIU+bNdOlCv
 VcaL7MZn3aWSNusLwhVCdKUbONHZln9/BdhnM9MWCgKtLffJQZ1l5YeWRew9hKXZlNhc/QDi2
 6OBB91qbZvwq/FECU4JbUtrL5vr5+aTWZFjJytZ43bTd2hjX3LQwlm/2qsi5shI/w1W7vRivo
 2LPv/aJ3slNtvFqx5n6artcjeuAKrNVO8cir0rylxbW5HFtYN8XyriYtBwFKBonfUHyFCff1x
 ZNvucpJRxrliynJ8vqGoWTnGaB2MjIeX7oQ/1QVNMj+w8XDx6CDofOqPQwLPluYdc6tIx1CHm
 3PlRz9/LPRmkyJdLdE1PGH1vps939IR3nQcBlDdho8BQL4it8z4AStPMJeOcpF35Hvme4rvPV
 EIRm7Y2jBjDA84ylfGQSEvuPdc+CGaxYbDpRBcs/px2tQA5nroQ97FqPYpwDq7fsvEDm/ZbAi
 U1QIG3zgNpEiQNPYm/DpQL1rHP2k6fxE5jHtDa0EAzsCYSpuMnRr8dUFA6M9blUtJOoVsIb8P
 3z3iEgL39Lg9dYe+HmgcFNj5ZogIFgO706f673B3PvAcw/MUlJKzJFZaLsLQBh+6C6Oq7zCV8
 214bNE6anZgwLWbyUCRwD0YOTivWWinzWjzCb+7NG7g0dIMK1I8k6AZC7j9MhEUySJX2VNm3v
 +TxxC3UX3TVVUIxxfGXcPyr/0DkxuvqGDxASQrW70O9Kbw+TDNTREYKlORrYQq1fao9xKlxR+
 RYJI0SdVM8HWvYei5+4JKb1g/Sa1MYQVuUvvM2J770lxfKwW+8R95mMOX5g3iSVVfFEgiuvAh
 7Xq44HvTv828XN3kLlULhxW1CwE0nPQgumTOx7Pioarz+wwRsINvHLqyrHP4uO1H3/AIb/knx
 bGIsv447wue91MPqg0wjiz/q/w2CvYg2FCutYux2ItRL1ecpAEpuq5hsNzDcR1640JgXoiNyY
 NBhvBsTPG9xnmwlSfJOQQHq0up0DwtbQHqvcxejT9PrlQy5yjz1Aj8WByBwYxhZlFUA7fAaNz
 2rZ/uWgmqkkuGICfRC1j8AImhdQRuouoOYS4xZONtc8Mftr5SuKPi4jwUsITakP0+fZe++RrQ
 Xilg3of8Id4w1bQlcDhsMQTpnue10sghOWuK2Voz2TTESQuVbwaEE5w1pNbcQ0NJxJIwj2GOM
 6FQOKVPqyBKLyFgqGi7lEQ8Z7ONu/Td2dfrflOd891pWyP39DnbAc+9PhvA9RnnxGCGsH71tj
 mSaFVVepnJJdIHE863vMcrI6IZkSj3iQPeCvDFe7TpE87hhbBnpqQs6nDz730A6FPaj+S36yR
 Ay4g2DMi6KQURc2v2D+XiQIKqMMPkRuq3jGdB2WZJstzUlfEAcMUCp55ndW0K82EoPdXoO7R6
 YAS2mKI0mnUJGDvxtBfV8bWHZ2NsJ5dtE2bqCyzTvmbW8AFRPGP49dw0xbwSoEqJ393lW1U5T
 4Mb/9ZMl+tA6WPjocKpyJ8kqwWr1KgVwUw1A5pK+vLxk19BjJawbY7I1PpMBKk2311405EXzM
 uUHrmTNGvQjewPRRXrqihXqK/JSi4sSFEIJrZopyGiibAnKNXmxutafnYcrizmMirDSqt409z
 7Dds+qGdhndOIFkPD7XGHP8iQrVQYg7RuVLDzto9QXkCAuJygiOWSKHcapihaN93LyC8XDfXa
 YYMG4ysg0fM0dd4klIosqdpfs9IDcQDgVGpF2E2oLx7ORugn3m+W46iZCrf+LDwXnW6eX77Cl
 bFzAmZPUP0WbGPQzVM5eAuKc7yVh+KGqeaqyFIPTCCtXW+Mg9MrgaGioLOb+AbEFF0wLBq6uL
 YGYd2Wr5GsXA8gXDmRmzbiPRPthcWdlxgBRqcjDB6o+fKJL6jG81jg1uCdGvFuA6cb0HTxi40
 UxrXGRxDn2mtNp12QJid9oO8hKupNQHo2nygIsW02Do79p8N0FIKwx1n9dCKWw5IW8P6lqZIB
 tZnFZPJFYTHABRhcua2xGt1j1gvU6Rgh2cUEhOMSqWvL/qk0Vm0o7Rc9EB/MK8G8IHL8+Kq73
 iIQBBTOanvgUS2WZfCyLcID7MgYKtlc/LgfIVR4cIfjQ3UBSFmUi4TRcIfoNDQwpKaxxW9VOQ
 yS/dOVP29tWqph0XvKFEJlpiAN9uowdULQM+sYcwxf60JWyhJoaBP+EOH+AM2XH5VFy+XJzZj
 BP9gZeIumP5WzPJlbzyHJLhVkbMsyqU8uo8gXVMPlgwJr1lJ8246HfjrKr8Bamt3QYiCdOZ7d
 8nb5FbSM8YW4kg3tGXO7zVVltDfX63HsfbgmW2A6u8YLP2asyzCrAzqeIi6pzg10UMuV7Zrte
 3lKru5EcOi0drxF4Ezmxf8mfmRl9vhs7DhW8QmABn3+HHJD3nKL+gauhS/pK23AJ1yxiz/59H
 MXo1rrnzucHWs0P6hGr3tAntBmq0KUebUhj4/WNxs/gRkWQyZPI4DB4Gx4lMjx5iqIXwDEZaY
 j4tKfP7DTZRCmweJk4M10gDveSTd2GLU6bBRK5a6OseGgptLaKC85P1eQHBEmsfkh/X54N1Nu
 otmsASB6i5JVL484QhiA2KPGGMhKvXe+kRagg9CtYPj2S6zMwN/J/NpzHZXZS3XbuDlvCKr0w
 Pu30sBDsNVhAALUPTJ/QoS3oqZnLT7CFLR2cJztrpBCgJKm7rD8jCyY1fS2hrqeTGvdONn1mR
 elIStZfHGaSxIyGKTN2RcwxsyYkVyIEr9kJjtRyNzxDwEEnGiQlQa+53+xI0LTu5KNI78BsLk
 uPcICuywDl4HF60QRU1KIGm8b522m9JKHzQa98G1Oh06qX7YFXhvRTMW681/U+50Ob1xyR2Sy
 aiNpZzSMo75xX6NaN6vlwZjiaIYmpaVh3U0PcxrTtRZS79XI6CvDzlB7nbWNThnBAW06u1MxP
 x1UWXPvJlFYKOXahrZGhmEcnkz62N96NFRy2U+qaEzWYX2HDgolVr40F2BVr3taQITZvxIagu
 zmxx4FPukXA0NCpaWuZ3Xwfa3okbjdF6UGM+PIdq2fare6jIQQOP7/mXVMk52rj5nbcBvP7YW
 Bmw8ZsxVH9H7bXWocpDyn4dT+UzWLj5cwWxoaomsWuvoRyg+ipysymwkvY4BHAqEYIGP+cv4H
 WfWi0q7HWxYR/D8ngXzj2m//qvxz+Ty1ZiEzpkHjtlghCWR+vQIz4nzs7HnyxFp3GaWmWux4O
 no84tvkKdGQpVgRNLd9TfS9pz3y8P3d7WRJk=
X-Mailman-Approved-At: Mon, 20 Apr 2026 22:33:40 +0200
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

Am 20=2E April 2026 13:36:09 MESZ schrieb Quentin Schulz <foss+uboot@0leil=
=2Enet>:
>From: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>
>This will allow a bunch of simplifications across the code base=2E
>Disabling NET is the equivalent of today's NO_NET choice=2E This means
>that if NET is enabled, either the legacy or lwIP stack is necessarily
>selected, which allows us to simplify if NET_LEGACY || NET_LWIP into
>if NET in a later commit=2E
>
>Config fragments - or defconfigs including other defconfigs - setting
>the network stack (NET_LEGACY or NET_LWIP) must also set NET (or unset
>NO_NET) if the config they apply to - or the included defconfigs -
>unsets NET (or selects NO_NET) as otherwise the NET_LEGACY and NET_LWIP
>symbols are unreachable=2E This is the case for the two defconfig modifie=
d
>in this commit=2E
>
>NO_NET is now a convenience symbol which hides NET entirely to avoid
>modifying many defconfigs=2E If one selected NO_NET to disable the
>networking stack in the past, this will still work for now=2E Technically=
,
>we should be using the "transitional" Kconfig attribute but that is only
>available since Kconfig from Linux kernel v6=2E18 and we're on 6=2E1 righ=
t
>now=2E
>
>Note that this moves CONFIG_SYS_RX_ETH_BUFFER from under the Network
>menu back into the main menu as it seems like it needs to be defined
>even when there's no need for NET support at all and menuconfig option
>doesn't work the same way as a menu=2E
>
>Signed-off-by: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>---
>
>I'd say we should have everything net-related depends on NET as well,
>so that disabling networking support with NET=3Dn is also disabling
>anything related (e=2Eg=2E Ethernet controller and PHY drivers, USB
>Ethernet, USB gadget CDC/RNDIS, network CLI commands, etc=2E)=2E
>---
> configs/am62px_evm_r5_ethboot_defconfig |  2 +-
> configs/j722s_evm_r5_ethboot_defconfig  |  2 +-
> net/Kconfig                             | 23 ++++++++++++-----------
> 3 files changed, 14 insertions(+), 13 deletions(-)
>
>diff --git a/configs/am62px_evm_r5_ethboot_defconfig b/configs/am62px_evm=
_r5_ethboot_defconfig
>index 8baec9d43ff=2E=2Edf49324b25a 100644
>--- a/configs/am62px_evm_r5_ethboot_defconfig
>+++ b/configs/am62px_evm_r5_ethboot_defconfig
>@@ -5,7 +5,7 @@ CONFIG_ARCH_K3=3Dy
> CONFIG_SOC_K3_AM62P5=3Dy
> CONFIG_TARGET_AM62P5_R5_EVM=3Dy
> CONFIG_DEFAULT_DEVICE_TREE=3D"k3-am62p5-r5-sk"
>-CONFIG_NET_LEGACY=3Dy
>+# CONFIG_NO_NET is not set

Does this imply that NET_LEGACY is the default? Choosing LEGACY as default=
 would not be plausible to me=2E We should use LWIP as default=2E Then ever=
y new board will use it, hopefully=2E

Best regards

Heinrich


> CONFIG_SPL_BOARD_INIT=3Dy
> CONFIG_SPL_DMA=3Dy
> CONFIG_SPL_ENV_SUPPORT=3Dy
>diff --git a/configs/j722s_evm_r5_ethboot_defconfig b/configs/j722s_evm_r=
5_ethboot_defconfig
>index e4682edb455=2E=2Ecc71f913d3c 100644
>--- a/configs/j722s_evm_r5_ethboot_defconfig
>+++ b/configs/j722s_evm_r5_ethboot_defconfig
>@@ -5,7 +5,7 @@ CONFIG_ARCH_K3=3Dy
> CONFIG_SOC_K3_J722S=3Dy
> CONFIG_TARGET_J722S_R5_EVM=3Dy
> CONFIG_DEFAULT_DEVICE_TREE=3D"k3-j722s-r5-evm"
>-CONFIG_NET_LEGACY=3Dy
>+# CONFIG_NO_NET is not set
> CONFIG_SPL_DRIVERS_MISC=3Dy
> CONFIG_SPL_BOARD_INIT=3Dy
> CONFIG_SPL_DMA=3Dy
>diff --git a/net/Kconfig b/net/Kconfig
>index 89d949b5f2c=2E=2Ee712a0dd2ac 100644
>--- a/net/Kconfig
>+++ b/net/Kconfig
>@@ -2,17 +2,22 @@
> # Network configuration
> #
>=20
>-menu "Networking"
>+config NO_NET
>+	bool "Disable networking"
>+	help
>+	  Transitional variable=2E Equivalent to setting NET=3Dn=2E
>+
>+menuconfig NET
>+	bool "Networking"
>+	depends on !NO_NET
>+	default y
>+
>+if NET
>=20
> choice
> 	prompt "Networking stack"
> 	default NET_LEGACY
>=20
>-config NO_NET
>-	bool "No networking support"
>-	help
>-	  Do not include networking support
>-
> config NET_LEGACY
> 	bool "Legacy U-Boot networking stack"
> 	select NETDEVICES
>@@ -231,8 +236,6 @@ endif   # if NET_LEGACY
>=20
> source "net/lwip/Kconfig"
>=20
>-if NET_LEGACY || NET_LWIP
>-
> config BOOTDEV_ETH
> 	bool "Enable bootdev for ethernet"
> 	depends on BOOTSTD
>@@ -276,7 +279,7 @@ config TFTP_BLOCKSIZE
> 	  almost-MTU block sizes=2E
> 	  You can also activate CONFIG_IP_DEFRAG to set a larger block=2E
>=20
>-endif   # if NET_LEGACY || NET_LWIP
>+endif   # if NET
>=20
> config SYS_RX_ETH_BUFFER
>         int "Number of receive packet buffers"
>@@ -286,5 +289,3 @@ config SYS_RX_ETH_BUFFER
>           controllers it is recommended to set this value to 8 or even h=
igher,
>           since all buffers can be full shortly after enabling the inter=
face on
>           high Ethernet traffic=2E
>-
>-endmenu
>

