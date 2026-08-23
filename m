Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E9EC5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 10:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35FBE606BD;
	Sun, 23 Aug 2026 10:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XgACXqX60CbP; Sun, 23 Aug 2026 10:12:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787479920;
	bh=Uw3CMtHURAmN/zRMkVBGlkUVocHnqPqlYUvZhMOxodY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gp18+74VO3+GKx3LyUMS/WjTgjBLrVCZ3nE45eRVsHm0PUyinLRgZrx9lOTVVFhPI
	 bg3coyU7xyf8YSKuKiIzXQZwErQ0kbEfKLfWYLzGN98Afi4gB+BTiElAqHc+Khe3eC
	 o/TVSBrTeh87nMB+u1inNd/Cy73QYetwOZBgsCklyjaBZHySXbxIqU/I3gvUG/HAzV
	 f/lxDIKHIKX4rU5J9Q9d9NLAK2zyWCXmsppOcivB7QcmX1r4PaQmrQKmMl8n9Nye6a
	 uetge7nMg5F/3l4mmU2bBE+2rImbNVbykn4ZsC/T8K6oq7MbyYMVCUmFwDwte4UIYY
	 7FxjjwlpnHL0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE28A6064C;
	Sun, 23 Aug 2026 10:12:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8097B396
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62FCC6064C
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ioWukJXEVDST for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 10:11:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=ESb5OGVW
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DF526062A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787479901; x=1788084701; i=xypron.glpk@gmx.de;
 bh=Uw3CMtHURAmN/zRMkVBGlkUVocHnqPqlYUvZhMOxodY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ESb5OGVWZ0XGtm9hfcnIDqPs4y8NMsDxTxqHh8Gse2k8hiWziY0XJFooC1vJWLXr
 DGim8IJM9C90yga/2Ar57CbOyiMA4fnRMmGmsTbvybJHD/taUKzCfNTG1CSM3Ertl
 WsrJ9dKCMdcxxPSE7Purq8P2y0pYHcu5TVZ3I6iBoX1HKisJcdbRnNfXYasLTQwjp
 vwaLKIIujfknOGsStlT3x26KbPBLUc5v2WFSDrrip7LHeWqvP+Nt5HGchZodzhtwS
 DOyTW+1ZIPJMTbc8wxOcqHvg5Azs490HFbN3UEliQFlRCxSh/5jr6w+MOB/0Zbo1b
 Fz02sZXAy8r4ly8PLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1wbzyO3KIS-00qUGp; Sun, 23
 Aug 2026 12:11:40 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Aaron Williams <awilliams@marvell.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>, Stefan Roese <sr@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Pranav Sanwal <pranav.sanwal@amd.com>, Johan Jonker <jbx6244@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] disk: drop Amiga partition table support
Date: Sun, 23 Aug 2026 12:11:28 +0200
Message-ID: <20260823101128.87329-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pn3YHNIeLkvK/9m7PsvgaPINBkcnETFsJ/mzR/ZDjypeDZbboWS
 evwDy/ffVxOQ8OQTMGQ3+jvUp0lkyvbeWC0yY4TuwjAAXx99wiAdBPPUKVmjohFwKVRLa/V
 0EUUN7WnsGQGgUiY9kyoTBXKsTjVmWQex8Eg6OKDT/3uEV2PbfUdw6EUNrVJOO0qex/+mLa
 HBPnSoB3XM+DB15QyftXA==
UI-OutboundReport: notjunk:1;M01:P0:DN+XNEj+jHU=;4YEWB4IVMY7mnUMB1D1HcjT9+NZ
 DruVezFNaUFOFE22JCnoa8KoSBc6ciZYKIABaE4NpsQ+TbNClJLKaY3544MbITZPLsHrmASVB
 EtyJsHqbo1vzuwBDpZUuKt8jBRQd+vyoNnWe9ZBzeDGat7OI8xuGMLq8FZadfJylzNOH6CyAo
 IngiHFfaQ43+md0yn70c1HQ5p7epknj3RcPLs5yoR+ssegKWPbYvQwfQgMrTyMTM1OX6isYPG
 NoKX4bcViNcklsuKwRAoXtySYeHNECIeK0LpYUiwTwrknT8kN+RZoVCK/qEolfzEm+dKLO/mS
 6VRZnuPGxamXBu34ENkT6sCf663icyCqC9DmqRIVm0fj3pvMe0H6pYTTTYV2YUwbRSTRQIbEU
 wSlE4doAdxuuPbA01DvckqfGZ3h/tQReeLQM83UtYfEHJyiFWLD80G43aSMKP8BIpbH7h3cdA
 38dmaTinqopgPOwRwdwGDxmQs49388k17F7+4OU6VhMLGaKYgWCksBY71dClFlzNDHEhPWTeM
 xgHRVTZesxd+u1p0BouqxZZXH0JLBY1yTWI/zIxyATPtNxrdgH5osAGjedXTo80Nm3VwpVZy6
 BDL67FybU2/tiMDpv/QOcWEe19NDV76W2mMTMswYmZ1+f/F7MJKcEoLKeOUw2cCgDGmpmgR9s
 xFq8GCiSmQmVBjnh3/4phymmjvkZtxUqHEFby3zFQiGAFHWu+cYNDa2GlqBjnORzLcHCf+krd
 W6pG040uBgy2GuSSd2CTjVojVEROMeN7N+ZtuppN94CtSXtePQw2NVr3/24pf+jdCHhWqSNMs
 L/+6KL0XmaPPbYMC5o+iiBHVnUD0JQMUfkOp0J8sxpRLPXBLpzv9THpqSKO6gtEUEsja45y78
 H2ETCOmI1KLuqbNkiKL/jtKqjvU0KwPkH7iDnEnNIevS8PUQGRiEbfP3ui6IV//GqkAiZvpiW
 L0ygeVdPK6HnWmpHET2lZBaPmwjOSRT/gDQLGUX+md1ej7EXgyjIldAQ8pwnroT9AiqLalgLQ
 g/5VbXwMtXKXtt6MMf/CLigLyCgn6ZhCMLVwhG1SlEDgBKSs3Mm3i8tVKaVqRksr+l9/4JBfs
 q0F0w6FzzJF2KwGQcuB1C7XqftU8sKDG1WFy3zLaPsKUYP8gF4BYYZTifvYoHtfHJYPyYzOd1
 U0+C0f4Clcw013WslUeS0Yn7pOIm2J6gPRw7em1PyFKK5Q2vLP8L/OyhTKmVBh9iTMfjpUPfm
 4YWWC+gTWA6dzi/9kbmVc20wiIkcrz58cWkZEzwcVtvNvlnJ4vpjlHvUKveeRFfdIvF8idwij
 0+kvcgXmKAbCGjpTd+4DvKKsSdzOVBlTqE3p0Ais/O3PUGGA/pgMmJLMnHmdyxHHa5577yZ1f
 efLIuYE4DyLzN64p+gEdfq+QjWvp2GToxNjBJQbHCYIq1cxjV6wqi1HmqgnpjHPjdgOgkuhsx
 kOgdpMa5Mu9RaxAI2c7bdyG7xocObuhtG/eTHAbU67pwkPZGB20l6Rj2h40rIiqp1CdyNxUTN
 PhAIXPSINPZSuwgpt4nbcHvq74F5jjipz8MV6nIGk5bbRUCH8YYe914zGEXmP/EdGwBeYRkE/
 1rhGvs7KY6IoaxqLAnyqLgcfqQqKtv7xRaS2QlSARKyYqtYgW7JWoJFGBXjM1vHG0FTe3kNZ8
 4LKtE9d/Rgt68UigzBa4rM4hW5tMw1TgGT4snk2CBBASDum9FCdw3gjKUnnDRfETJE6n0xg5T
 CGW2S+Dr5GGcDzIrYHIeVQBZ/zMl7vDApStIXJyraaAUFVXJ3yUC10ds1AxnWk2iTfHO4lWGk
 hERJwG8xMBYIeXTCPk/Q+RDTug9Nzj1gN4qI6Ss5E3yFH4wMksWaV2Xk+DyRukz95+fsNdCcO
 /d4V/TPy12djD0NF+Rb9XgjxNcYU61MiEooay/Ag/TG5fQK3LPwDfwEOv5npENl48fFfNuzxp
 iHN2fVOH0qVd0952243Iqw3DWZwWYLl/5APb9ovy1GPPd8vIMe61qzBRwavibD7VjfNPnt6vO
 zaXrv9WWG6OpJXiLBAVLDOT/E1aHp7UwCKrHjCrovw7hJLHrlcdS20XJKCzmJy3RAobPKxIZc
 8UN41MagY9geauazm5/MYh3jXiiJBbbG6807RTqsUwis7MQ7v8Xe6w96KCjWbX9bXy1/F98c9
 io+GqavS1yIwz+KAnDh8Lwi/Ojdw/SXUG8Q2DVTrfn5sW5vRUT8o42yf1zWNS0BCAXZ9JwW/d
 n+QhcPiH2tJwRs8TVRoCg0uFtE+frHjwEGmOhnZnAu0HrMWNz4ZPyEh7I+bpSc1Xv9CEasb/Y
 pnrzaTfbRthnaG17WatamD6r1rw8yodh17PSrH3AFHRND7S5y6eydUab+axQ+CcvSIzo4ZEq6
 jVCZ5uqXTipVxupnK89tEVL4WhCZObdv+1Sfsj6TM/3dJXSZZpRiHstqGeyaP6LEAML1I+JOv
 F6TzFDhZuF244vg9CyQr2Hapj0LmgIglRudoLQ37LWAprYXvgdWUDyUJJXeT4j743PkZ59yXT
 oh7QL6FTWMn2KLMDaiAftH6EXTbsKG/Mh7O9tAXbjb3kNpTP/N2+c67PvA2lkrn8io7Y3Ddzj
 1SmBCj+Eh6JN4GLR0m/b9V6UV8I3nWVZnjEg40I3BXvBm8BK4YMUG3sSF7uq+ehfFx1Wv9Gun
 xYzkCx+fDaOxzjqGWeUm8NGX79x/I2iAgPoPrJHbyp1sz1SwJ63Mc0gw99el8KPVEJHIbEqHA
 mEn0sYowpVyblAHu1fLknHNKhHjvsXPCs7l/9c3c7CJ8ECECbbJD0Uw+tcgMpAtW3z9wxIpNx
 xAuny01KWRtyAw3HUrFN1aC3AvsTDqvpBW1sovKYeFwM6BwPlK55eQnYFBOgI/yIfiznR9RYy
 dndCt3+ZkYAows4IcB75IS/t01DSbUxoxw43iJwgjHhe+QFqKLQGIrQyreqh7YoiWhN8ph99N
 IHpjhUtVQ6g8qRJ8LBPjI0FqYD42Z4KTbMM3K+OdLHmmj4b6rHJ8LcyLyy53lCBiUq/Gjav+3
 obw7ypYgYP9CJX4nQ6KqGAsVRYwMA5Tr8k7iKHI47BfKAlSwF5LevwJoWvP3Ajw8Jl8DoRv7m
 FG0OtxDLXr7BhEmQT8we7J1NZr1SawpXR0D5OtjKqLi+IL5jG5Qebo4rxduR+Fc9O9uLiG43V
 ITlzm2KXGrIUqFT/coda92fMYnITjc2NlKqEvfhU6IuzBHIKLSUPapY0hmu8lJxk+56ETG0E9
 SWP02Z+fmpjeVhv0mwDdxLDBocULjrAOuOmObsqEcqBbNFwQbPSkE0IkrhFy4CiG6GZGOBq2W
 9sbzQKGbQkiZdQ12k/JXkqKV/mpeYvLZOsaDsYB3FwwLlt+DySq8fQUWMm3gruPS/+punaGek
 eefMu3raR6VBnp7J47WikRQxf72yihak6/KyWsyz7cs+x0HqFeKU63n2sFJqHxmPn2DHl8oBj
 5RB4uLVtW5Rrxrospz3iL+K1+PTTR3HufxgBoMVGKNLfqrLy3uFhXKJE/mA/qj/S5rNyZXcrt
 zlYprkO5eakFsof/uQctzngagpg5MraBX9FLEwKJ9I0FgOTLm38UhNPaS7Bp/dhy16IbiejY2
 5rX9JqP87MOBY4ep0ACLW+kt6ucQUqYBGqMu7D6XLRRqkDz4Km3MrREOnqx61LsK7ROOAz6QY
 b3hnQpqAaqtryw8RVKFEV652F2iuxEedlaXZl+2/hDs0DZTVf3iysQIJGqa5BqvMcB5zOitun
 q8upDMdiIK7tdqfkNSEhzpPtGSUQvqA2QZUVbDRvYz3ysOnpswN7KjVDG+UlaVI3H89ovd9Ij
 dY+d7O1zVr+2OoZ/45+xz6pgWjYgSeQ9EdYfVWjNWDXnZBqifK4gaeWNuyEQ8dJ5PVeJLbSKP
 kDDENSNsZFzVPNaICsStVj529OEyCxqjOQKf2HFiZPfTX7CQwr1nJ2NKklvL6DQxYqorKJ54G
 6rrqXNj2fM58otuAxT6+58WKr/WaqxPFRrd/rRWaCNL+jgz/d4/J5IaH08F/h2YO/fsGKvltc
 NYnIs3kDcyD6qGZHTuqtYK2NQ99OXatA7kAyjMj7k6J1YyktUNaK2M8uNewwIETGz0gLUrf52
 nxrwmoekVj5J6c9mL7YfQMIzyi2mtmCg6UV5cNcUyOLscVU8olUaOhdw+iYDdo27DiFNmtsQl
 wrLo/cD2RejQyPad1UiXdEXoCXCkmYiO7P0PTYXwkV7DQpimFPCnHWQYfNgT2ricj+KQFz8r5
 Vm9aiDhP0AbLg5cFBDr2oeHyqSowjbhR/jYjXYmclbUw7CMDVMLukC5mmry7QD7E/C0V0tQPY
 EibHOQKQwNElFM2NsSuaCx1tmS13V7H6j9CCyqIuKO1z6bil48qHhGVuYh03mvdAafUtYmyLr
 IpLCWv/i5tL10THe4FdVvYPRSD8zYC3sh7zqJKnzVAvaKM1znvAuzysk9rDcf4zozV9l21scy
 KwBNV/Lp/4nsAarcBI7ge0IMJzQRVo5v3kiAf1rA8xRmq29DuznD6DSqJnh6GgikOKVyuzy1B
 1bFhPUv2aBrvYjxyDbhR1eYMXLHGGljPVr0zL8u0WaFait7rSswCf2RUptwVC4u0OG70YY+k8
 rf298lMAyfxeh8ZNreTScoH0KL5Acj27xPqCEkPoTWpojT9MZSel9WgE95CXQDxQBUV2mwDBF
 zza+9JLqi2D2Zn0nhvkh58cGXy45rjoBPMv62uECzeE/FEsY3jEF/xSvK/W8gb1Flc+xxQoKT
 pK5MOHnDiJfu0Pe71LG37MgQcfXbnukfRHojAhT/Vb4ed0qYFi98jAXBv5eMBt0ZpcZqqOAoZ
 P9LYLxrGQSjbCXi+ECl0YGhd9gBOD7eGJsL0FKMPVh0XuEaLon4I03t1FPZI5zdVUBlwaOCwu
 dNW4AKq8VKUnWGNl9DGawpLM15r7PhIhRm9omsoMoeADholYSS7+Tq8Yc18Gs1RHIWfROQY4c
 7lXJ+VGjyyb8poVCj5UWtV0gVz6Jox1BuwyBLcs3Xo2mFzas4OYvqlc7fvD1xKiqE17CtXkNI
 D5rUBuMe9I3qC1Ojs/fHv84lIUTMuUpdGZsNoD1Fvo/yLuvDO6JH3BOjXiusRPUQCsXPIA5VF
 JHXovOwzqDcf0dp7jjgHGk2AyPFcNp4D0EPXHRXlwc7Bj81Ezb0UZt5pWX/OWBI2kY4OVQeYS
 M33F1MAzSez7kZ07Hx0ZZIZfO+RKtkFpOhJgwjYTgOSgFoqrVSZZ/8wHtx6N4LGd7nNbfk2wv
 y5RHmnsQIpGP69UJ6azOMOD1j+CEHAXZYP2cjo0AN6KNO1aNInM40+uqYC7B78Oe4q8Ptss0Q
 Cf5LHbRWQEIUaG7D6ujI/Zxkj5oXVqSdvTyTt1btcrultYPVc+7EdUZTtDlkXMX4N38szQF+6
 iMmsginOz853Ri/PxxOrCe7oDnymRNaHVc5Ck0g6uurxs06wdEhEt7iynSDdNAlJqGpndmzGY
 5YftDwLGKhHO/NGKrZ6HLI2ZeFiTsV4sRLDT3tNccCcdYV4gIiZwaUrO+AbSGCVjidHKgZoNj
 kogbRbyHo1CQWXDZgFTQRPb+26dSuBi02VGGINrnUkz5n35zP5LCGroPDmiPhIb76PUtOwnNV
 L76PZKNGEvgHdFyo6jQ6s4VwIKm8ODwKwCP9VrBxRQQ8yu6OxArbxjO1kT/GWe9KXn0DOfr0q
 uIJ4p82ZUCkAlRPR9k28OGOU+oqJkqUiA2c42Aha0U8aoj91jBxB0GlH0W20XNSeNnUiJGM+P
 MJwKVftlN7xvwXbZ0KTILa8Lhms6e5hv25dtJvPqP6tqKsAgbXJ+lDfIXEOcNp6Jjlox4iXC9
 hHUsNf7HMqj6yF+Fmu3UhxEIAScph3fAxwEL6Jy33Q1s7jwckOLgnFNdUbwFAWrEGSi16/7Wl
 rNmJLyZemGM41fH9rCeAydkLWdKUfwFgKaXSCz5WhJbWLL07b+zjmnn4bQHU+FQ3YINAWJq3u
 tfLgKqZE/Elzg//qAWMttebaKvw08STqkoVVORGCwELlAIMm3XEo019eBJYsnEY6VKxo/f5QI
 9azJEDHCGHyFFHxB+mf38pYcUKK68zp1Saibz4xUd7+/Yzco7oftQo384VzI2GILSd3brjQtJ
 aKgfPsuEfpvDTMSeeETKedg5Ud9YjsRGi6cgrF8UB+Nx/hteIYKu2UHP8hEdyxdCJNgultzF3
 xShsxHKRj4axSNl5cYQni0lFleUQpc7RozSAC2FfNu4rLLPYaE14RViEkc4SepHyhbUczRkxW
 7U51jewy4C1PlmyS7CMO8ST5/Fl4z2P1OSV5qtdJ7jiI8KXdIiYVZeKKquZ4Pb9B162lDDJtI
 WuAZnxRphHtG109P8RUfoSgvHyAfyxzf7SoEWsoABOf5x2sd+gLkPAkbfcC6nguLxebti4SCe
 rxodDlp/XKHBSxvCb/l+X8G91vrI3JEVj/MLo/lMIHzKCnhoukAFMdqMt11TemV1WCIGZ8YEo
 cGIt8cYEt4/b4RrT6izzaQFCjC0/zfPxp8quOwGyLyZznUXKeHCbEg9P1tJD2XVi/dhXUhL1y
 jvYHboqFiT+AYFVwQJ+PXTASAji1l/BhbWc9Cj9CRU4jSOpruPKZ0HjBfaHquBnDg0bHjk/4E
 LwtzmQHYVZP/0ibtjyzxCfG9OB8Pg/OWUVJ6+hysIQkRR2RoCaaktLf0PzeQ3Gb8+Nn+ZRqAt
 bvB89orIv4NwdIPA3wzogK/omUAStv9VyHnPdn45/0CJha0qFR+EDQ==
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

The AmigaOne is not supported anymore by U-Boot.
There seems to be no need to keep support for Amiga partition tables
anymore.

The usage in sandbox*defconfig has been for compile testing only.
theodorable-x86-conga-qa3-e3845-pcie-x4_defconfig and
octeon_ebb7304_defconfig support GPT partition tables.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 configs/octeon_ebb7304_defconfig              |   1 -
 configs/sandbox64_defconfig                   |   1 -
 configs/sandbox_flattree_defconfig            |   1 -
 configs/sandbox_noinst_defconfig              |   1 -
 configs/sandbox_spl_defconfig                 |   1 -
 ...able-x86-conga-qa3-e3845-pcie-x4_defconfig |   1 -
 disk/Kconfig                                  |  13 -
 disk/Makefile                                 |   1 -
 disk/part.c                                   |   1 -
 disk/part_amiga.c                             | 385 ------------------
 disk/part_amiga.h                             | 137 -------
 doc/usage/cmd/part.rst                        |   2 +-
 include/part.h                                |   2 -
 13 files changed, 1 insertion(+), 546 deletions(-)
 delete mode 100644 disk/part_amiga.c
 delete mode 100644 disk/part_amiga.h

diff --git a/configs/octeon_ebb7304_defconfig b/configs/octeon_ebb7304_def=
config
index 2b7210cd4fb..d441bf71f50 100644
=2D-- a/configs/octeon_ebb7304_defconfig
+++ b/configs/octeon_ebb7304_defconfig
@@ -38,7 +38,6 @@ CONFIG_CMD_TIME=3Dy
 CONFIG_CMD_EXT4=3Dy
 CONFIG_CMD_FAT=3Dy
 CONFIG_CMD_FS_GENERIC=3Dy
-CONFIG_AMIGA_PARTITION=3Dy
 CONFIG_EFI_PARTITION=3Dy
 CONFIG_PARTITION_TYPE_GUID=3Dy
 CONFIG_ENV_IS_IN_FLASH=3Dy
diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 2e37374d646..5dae5d87894 100644
=2D-- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -103,7 +103,6 @@ CONFIG_CMD_EXT4_WRITE=3Dy
 CONFIG_CMD_MTDPARTS=3Dy
 CONFIG_CMD_SPAWN=3Dy
 CONFIG_MAC_PARTITION=3Dy
-CONFIG_AMIGA_PARTITION=3Dy
 CONFIG_OF_LIVE=3Dy
 CONFIG_ENV_IS_NOWHERE=3Dy
 CONFIG_ENV_IS_IN_FAT=3Dy
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree=
_defconfig
index 4ad2bb01673..3f722c0b85c 100644
=2D-- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -77,7 +77,6 @@ CONFIG_CMD_TPM=3Dy
 CONFIG_CMD_TPM_TEST=3Dy
 CONFIG_CMD_EXT4_WRITE=3Dy
 CONFIG_MAC_PARTITION=3Dy
-CONFIG_AMIGA_PARTITION=3Dy
 CONFIG_ENV_IS_NOWHERE=3Dy
 CONFIG_ENV_IS_IN_FAT=3Dy
 CONFIG_ENV_IS_IN_EXT4=3Dy
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_def=
config
index 076be6586cf..29afc12b6ed 100644
=2D-- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -113,7 +113,6 @@ CONFIG_CMD_CBFS=3Dy
 CONFIG_CMD_CRAMFS=3Dy
 CONFIG_CMD_EXT4_WRITE=3Dy
 CONFIG_MAC_PARTITION=3Dy
-CONFIG_AMIGA_PARTITION=3Dy
 CONFIG_SPL_OF_CONTROL=3Dy
 CONFIG_SPL_OF_PLATDATA=3Dy
 CONFIG_SPL_OF_REAL=3Dy
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 3b6d18d7d76..f83a9eb8ef4 100644
=2D-- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -91,7 +91,6 @@ CONFIG_CMD_CBFS=3Dy
 CONFIG_CMD_CRAMFS=3Dy
 CONFIG_CMD_EXT4_WRITE=3Dy
 CONFIG_MAC_PARTITION=3Dy
-CONFIG_AMIGA_PARTITION=3Dy
 CONFIG_SPL_OF_CONTROL=3Dy
 CONFIG_SPL_OF_PLATDATA=3Dy
 CONFIG_SPL_OF_PLATDATA_INST=3Dy
diff --git a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig b/c=
onfigs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
index ebe333b0b16..1529efb113a 100644
=2D-- a/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
+++ b/configs/theadorable-x86-conga-qa3-e3845-pcie-x4_defconfig
@@ -47,7 +47,6 @@ CONFIG_CMD_EXT4_WRITE=3Dy
 CONFIG_CMD_FAT=3Dy
 CONFIG_CMD_FS_GENERIC=3Dy
 CONFIG_ISO_PARTITION=3Dy
-CONFIG_AMIGA_PARTITION=3Dy
 CONFIG_ENV_OVERWRITE=3Dy
 CONFIG_ENV_REDUNDANT=3Dy
 CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
diff --git a/disk/Kconfig b/disk/Kconfig
index 672ad46a48f..ea4df87b243 100644
=2D-- a/disk/Kconfig
+++ b/disk/Kconfig
@@ -86,19 +86,6 @@ config SPL_ISO_PARTITION
 	depends on SPL
 	select SPL_PARTITIONS
=20
-config AMIGA_PARTITION
-	bool "Enable AMIGA partition table"
-	select PARTITIONS
-	help
-	  Say Y here if you would like to use device under U-Boot which
-	  were partitioned under AmigaOS.
-
-config SPL_AMIGA_PARTITION
-	bool "Enable AMIGA partition table for SPL"
-	depends on SPL
-	default y if AMIGA_PARTITION
-	select SPL_PARTITIONS
-
 config EFI_PARTITION
 	bool "Enable EFI GPT partition table"
 	default y if BOOT_DEFAULTS
diff --git a/disk/Makefile b/disk/Makefile
index 2248a659f8b..64f164f3b67 100644
=2D-- a/disk/Makefile
+++ b/disk/Makefile
@@ -15,6 +15,5 @@ ifneq ($(CONFIG_$(PHASE_)BLK),$(CONFIG_SPL_LEGACY_BLOCK)=
,)
 obj-$(CONFIG_$(PHASE_)MAC_PARTITION)   +=3D part_mac.o
 obj-$(CONFIG_$(PHASE_)DOS_PARTITION)   +=3D part_dos.o
 obj-$(CONFIG_$(PHASE_)ISO_PARTITION)   +=3D part_iso.o
-obj-$(CONFIG_$(PHASE_)AMIGA_PARTITION) +=3D part_amiga.o
 obj-$(CONFIG_$(PHASE_)EFI_PARTITION)   +=3D part_efi.o
 endif
diff --git a/disk/part.c b/disk/part.c
index 4923dc44593..3c9bba9b328 100644
=2D-- a/disk/part.c
+++ b/disk/part.c
@@ -315,7 +315,6 @@ static void print_part_header(const char *type, struct=
 blk_desc *desc)
 #if CONFIG_IS_ENABLED(MAC_PARTITION) || \
 	CONFIG_IS_ENABLED(DOS_PARTITION) || \
 	CONFIG_IS_ENABLED(ISO_PARTITION) || \
-	CONFIG_IS_ENABLED(AMIGA_PARTITION) || \
 	CONFIG_IS_ENABLED(EFI_PARTITION) || \
 	CONFIG_IS_ENABLED(MTD_PARTITIONS)
 	printf("\nPartition Map for %s device %d  --   Partition Type: %s\n\n",
diff --git a/disk/part_amiga.c b/disk/part_amiga.c
deleted file mode 100644
index 22bf99f1b88..00000000000
=2D-- a/disk/part_amiga.c
+++ /dev/null
@@ -1,385 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2001
- * Hans-Joerg Frieden, Hyperion Entertainment
- * Hans-JoergF@hyperion-entertainment.com
- */
-#include <command.h>
-#include <env.h>
-#include "part_amiga.h"
-#include <part.h>
-#include <vsprintf.h>
-
-#undef AMIGA_DEBUG
-
-#ifdef AMIGA_DEBUG
-#define PRINTF(fmt, args...) printf(fmt ,##args)
-#else
-#define PRINTF(fmt, args...)
-#endif
-
-struct block_header
-{
-    u32 id;
-    u32 summed_longs;
-    s32 chk_sum;
-};
-
-static unsigned char block_buffer[DEFAULT_SECTOR_SIZE];
-static struct rigid_disk_block rdb =3D {0};
-static struct bootcode_block bootcode =3D {0};
-
-/*
- * Copy a bcpl to a c string
- */
-static void bcpl_strcpy(char *to, char *from)
-{
-    int len =3D *from++;
-
-    while (len)
-    {
-	*to++ =3D *from++;
-	len--;
-    }
-    *to =3D 0;
-}
-
-/*
- * Print a BCPL String. BCPL strings start with a byte with the length
- * of the string, and don't contain a terminating nul character
- */
-static void bstr_print(char *string)
-{
-    int len =3D *string++;
-    char buffer[256];
-    int i;
-
-    i =3D 0;
-    while (len)
-    {
-	buffer[i++] =3D *string++;
-	len--;
-    }
-
-    buffer[i] =3D 0;
-    printf("%-10s", buffer);
-}
-
-/*
- * Sum a block. The checksum of a block must end up at zero
- * to be valid. The chk_sum field is selected so that adding
- * it yields zero.
- */
-int sum_block(struct block_header *header)
-{
-    s32 *block =3D (s32 *)header;
-    u32 i;
-    s32 sum =3D 0;
-
-    for (i =3D 0; i < header->summed_longs; i++)
-	sum +=3D *block++;
-
-    return (sum !=3D 0);
-}
-
-/*
- * Print an AmigaOS disk type. Disk types are a four-byte identifier
- * describing the file system. They are usually written as a three-letter
- * word followed by a backslash and a version number. For example,
- * DOS\0 would be the original file system. SFS\0 would be SmartFileSyste=
m.
- * DOS\1 is FFS.
- */
-static void print_disk_type(u32 disk_type)
-{
-    char buffer[6];
-    buffer[0] =3D (disk_type & 0xFF000000)>>24;
-    buffer[1] =3D (disk_type & 0x00FF0000)>>16;
-    buffer[2] =3D (disk_type & 0x0000FF00)>>8;
-    buffer[3] =3D '\\';
-    buffer[4] =3D (disk_type & 0x000000FF) + '0';
-    buffer[5] =3D 0;
-    printf("%s", buffer);
-}
-
-/*
- * Print the info contained within the given partition block
- */
-static void print_part_info(struct partition_block *p)
-{
-    struct amiga_part_geometry *g;
-
-    g =3D (struct amiga_part_geometry *)&(p->environment);
-
-    bstr_print(p->drive_name);
-    printf("%6d\t%6d\t",
-	   g->low_cyl * g->block_per_track * g->surfaces ,
-	   (g->high_cyl - g->low_cyl + 1) * g->block_per_track * g->surfaces - 1=
);
-    print_disk_type(g->dos_type);
-    printf("\t%5d\n", g->boot_priority);
-}
-
-/*
- * Search for the Rigid Disk Block. The rigid disk block is required
- * to be within the first 16 blocks of a drive, needs to have
- * the ID AMIGA_ID_RDISK ('RDSK') and needs to have a valid
- * sum-to-zero checksum
- */
-struct rigid_disk_block *get_rdisk(struct blk_desc *desc)
-{
-    int i;
-    int limit;
-    char *s;
-
-    s =3D env_get("amiga_scanlimit");
-    if (s)
-	limit =3D dectoul(s, NULL);
-    else
-	limit =3D AMIGA_BLOCK_LIMIT;
-
-    for (i=3D0; i<limit; i++)
-    {
-	ulong res =3D blk_dread(desc, i, 1, (ulong *)block_buffer);
-	if (res =3D=3D 1)
-	{
-	    struct rigid_disk_block *trdb =3D (struct rigid_disk_block *)block_b=
uffer;
-	    if (trdb->id =3D=3D AMIGA_ID_RDISK)
-	    {
-		PRINTF("Rigid disk block suspect at %d, checking checksum\n",i);
-		if (sum_block((struct block_header *)block_buffer) =3D=3D 0)
-		{
-		    PRINTF("FOUND\n");
-		    memcpy(&rdb, trdb, sizeof(struct rigid_disk_block));
-		    return (struct rigid_disk_block *)&rdb;
-		}
-	    }
-	}
-    }
-    PRINTF("Done scanning, no RDB found\n");
-    return NULL;
-}
-
-/*
- * Search for boot code
- * Again, the first boot block must be located somewhere in the first 16 =
blocks, or rooted in the
- * Ridgid disk block
- */
-
-struct bootcode_block *get_bootcode(struct blk_desc *desc)
-{
-    int i;
-    int limit;
-    char *s;
-
-    s =3D env_get("amiga_scanlimit");
-    if (s)
-	limit =3D dectoul(s, NULL);
-    else
-	limit =3D AMIGA_BLOCK_LIMIT;
-
-    PRINTF("Scanning for BOOT from 0 to %d\n", limit);
-
-    for (i =3D 0; i < limit; i++)
-    {
-	ulong res =3D blk_dread(desc, i, 1, (ulong *)block_buffer);
-	if (res =3D=3D 1)
-	{
-	    struct bootcode_block *boot =3D (struct bootcode_block *)block_buffe=
r;
-	    if (boot->id =3D=3D AMIGA_ID_BOOT)
-	    {
-		PRINTF("BOOT block at %d, checking checksum\n", i);
-		if (sum_block((struct block_header *)block_buffer) =3D=3D 0)
-		{
-		    PRINTF("Found valid bootcode block\n");
-		    memcpy(&bootcode, boot, sizeof(struct bootcode_block));
-		    return &bootcode;
-		}
-	    }
-	}
-    }
-
-    PRINTF("No boot code found on disk\n");
-    return 0;
-}
-
-/*
- * Test if the given partition has an Amiga partition table/Rigid
- * Disk block
- */
-static int part_test_amiga(struct blk_desc *desc)
-{
-    struct rigid_disk_block *rdb;
-    struct bootcode_block *bootcode;
-
-    PRINTF("part_test_amiga: Testing for an Amiga RDB partition\n");
-
-	rdb =3D get_rdisk(desc);
-    if (rdb)
-    {
-	bootcode =3D get_bootcode(desc);
-	if (bootcode)
-	    PRINTF("part_test_amiga: bootable Amiga disk\n");
-	else
-	    PRINTF("part_test_amiga: non-bootable Amiga disk\n");
-
-	return 0;
-    }
-    else
-    {
-	PRINTF("part_test_amiga: no RDB found\n");
-	return -1;
-    }
-
-}
-
-/*
- * Find partition number partnum on the given drive.
- */
-static struct partition_block *find_partition(struct blk_desc *desc,
-					      int partnum)
-{
-    struct rigid_disk_block *rdb;
-    struct partition_block *p;
-    u32 block;
-
-    PRINTF("Trying to find partition block %d\n", partnum);
-	rdb =3D get_rdisk(desc);
-    if (!rdb)
-    {
-	PRINTF("find_partition: no rdb found\n");
-	return NULL;
-    }
-
-    PRINTF("find_partition: Scanning partition list\n");
-
-    block =3D rdb->partition_list;
-    PRINTF("find_partition: partition list at 0x%x\n", block);
-
-    while (block !=3D 0xFFFFFFFF)
-    {
-	ulong res =3D blk_dread(desc, block, 1, (ulong *)block_buffer);
-	if (res =3D=3D 1)
-	{
-	    p =3D (struct partition_block *)block_buffer;
-	    if (p->id =3D=3D AMIGA_ID_PART)
-	    {
-		PRINTF("PART block suspect at 0x%x, checking checksum\n",block);
-		if (sum_block((struct block_header *)p) =3D=3D 0)
-		{
-		    if (partnum =3D=3D 0) break;
-		    else
-		    {
-			partnum--;
-			block =3D p->next;
-		    }
-		}
-	    } else block =3D 0xFFFFFFFF;
-	} else block =3D 0xFFFFFFFF;
-    }
-
-    if (block =3D=3D 0xFFFFFFFF)
-    {
-	PRINTF("PART block not found\n");
-	return NULL;
-    }
-
-    return (struct partition_block *)block_buffer;
-}
-
-/*
- * Get info about a partition
- */
-static int part_get_info_amiga(struct blk_desc *desc, int part,
-			       struct disk_partition *info)
-{
-	struct partition_block *p =3D find_partition(desc, part - 1);
-    struct amiga_part_geometry *g;
-    u32 disk_type;
-
-    if (!p) return -1;
-
-    g =3D (struct amiga_part_geometry *)&(p->environment);
-    info->start =3D g->low_cyl  * g->block_per_track * g->surfaces;
-    info->size  =3D (g->high_cyl - g->low_cyl + 1) * g->block_per_track *=
 g->surfaces - 1;
-    info->blksz =3D rdb.block_bytes;
-    bcpl_strcpy((char *)info->name, p->drive_name);
-
-    disk_type =3D g->dos_type;
-
-    info->type[0] =3D (disk_type & 0xFF000000)>>24;
-    info->type[1] =3D (disk_type & 0x00FF0000)>>16;
-    info->type[2] =3D (disk_type & 0x0000FF00)>>8;
-    info->type[3] =3D '\\';
-    info->type[4] =3D (disk_type & 0x000000FF) + '0';
-    info->type[5] =3D 0;
-
-    return 0;
-}
-
-static void part_print_amiga(struct blk_desc *desc)
-{
-    struct rigid_disk_block *rdb;
-    struct bootcode_block *boot;
-    struct partition_block *p;
-    u32 block;
-    int i =3D 1;
-
-	rdb =3D get_rdisk(desc);
-    if (!rdb)
-    {
-	PRINTF("part_print_amiga: no rdb found\n");
-	return;
-    }
-
-    PRINTF("part_print_amiga: Scanning partition list\n");
-
-    block =3D rdb->partition_list;
-    PRINTF("part_print_amiga: partition list at 0x%x\n", block);
-
-    printf("Summary:  DiskBlockSize: %d\n"
-	   "          Cylinders    : %d\n"
-	   "          Sectors/Track: %d\n"
-	   "          Heads        : %d\n\n",
-	   rdb->block_bytes, rdb->cylinders, rdb->sectors,
-	   rdb->heads);
-
-    printf("                 First   Num. \n"
-	   "Nr.  Part. Name  Block   Block  Type        Boot Priority\n");
-
-    while (block !=3D 0xFFFFFFFF)
-    {
-	ulong res;
-
-	PRINTF("Trying to load block #0x%X\n", block);
-
-	res =3D blk_dread(desc, block, 1, (ulong *)block_buffer);
-	if (res =3D=3D 1)
-	{
-	    p =3D (struct partition_block *)block_buffer;
-	    if (p->id =3D=3D AMIGA_ID_PART)
-	    {
-		PRINTF("PART block suspect at 0x%x, checking checksum\n",block);
-		if (sum_block((struct block_header *)p) =3D=3D 0)
-		{
-		    printf("%-4d ", i); i++;
-		    print_part_info(p);
-		    block =3D p->next;
-		}
-	    } else block =3D 0xFFFFFFFF;
-	} else block =3D 0xFFFFFFFF;
-    }
-
-	boot =3D get_bootcode(desc);
-    if (boot)
-    {
-	printf("Disk is bootable\n");
-    }
-}
-
-U_BOOT_PART_TYPE(amiga) =3D {
-	.name		=3D "AMIGA",
-	.part_type	=3D PART_TYPE_AMIGA,
-	.max_entries	=3D AMIGA_ENTRY_NUMBERS,
-	.get_info	=3D part_get_info_amiga,
-	.print		=3D part_print_amiga,
-	.test		=3D part_test_amiga,
-};
diff --git a/disk/part_amiga.h b/disk/part_amiga.h
deleted file mode 100644
index 3c27bfe8fde..00000000000
=2D-- a/disk/part_amiga.h
+++ /dev/null
@@ -1,137 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2000
- * Hans-Joerg Frieden, Hyperion Entertainment
- * Hans-JoergF@hyperion-entertainment.com
- */
-
-#ifndef _DISK_PART_AMIGA_H
-#define _DISK_PART_AMIGA_H
-
-#if CONFIG_IS_ENABLED(ISO_PARTITION)
-/* Make the buffers bigger if ISO partition support is enabled -- CD-ROMS
-   have 2048 byte blocks */
-#define DEFAULT_SECTOR_SIZE   2048
-#else
-#define DEFAULT_SECTOR_SIZE	512
-#endif
-
-#define AMIGA_BLOCK_LIMIT 16
-
-/*
- * Amiga disks have a very open structure. The head for the partition tab=
le information
- * is stored somewhere within the first 16 blocks on disk, and is called =
the
- * "RigidDiskBlock".
- */
-
-struct rigid_disk_block
-{
-    u32 id;
-    u32 summed_longs;
-    s32 chk_sum;
-    u32 host_id;
-    u32 block_bytes;
-    u32 flags;
-    u32 bad_block_list;
-    u32 partition_list;
-    u32 file_sys_header_list;
-    u32 drive_init;
-    u32 bootcode_block;
-    u32 reserved_1[5];
-
-    /* Physical drive geometry */
-    u32 cylinders;
-    u32 sectors;
-    u32 heads;
-    u32 interleave;
-    u32 park;
-    u32 reserved_2[3];
-    u32 write_pre_comp;
-    u32 reduced_write;
-    u32 step_rate;
-    u32 reserved_3[5];
-
-    /* logical drive geometry */
-    u32 rdb_blocks_lo;
-    u32 rdb_blocks_hi;
-    u32 lo_cylinder;
-    u32 hi_cylinder;
-    u32 cyl_blocks;
-    u32 auto_park_seconds;
-    u32 high_rdsk_block;
-    u32 reserved_4;
-
-    char disk_vendor[8];
-    char disk_product[16];
-    char disk_revision[4];
-    char controller_vendor[8];
-    char controller_product[16];
-    char controller_revision[4];
-
-    u32 reserved_5[10];
-};
-
-/*
- * Each partition on this drive is defined by such a block
- */
-
-struct partition_block
-{
-    u32 id;
-    u32 summed_longs;
-    s32 chk_sum;
-    u32 host_id;
-    u32 next;
-    u32 flags;
-    u32 reserved_1[2];
-    u32 dev_flags;
-    char drive_name[32];
-    u32 reserved_2[15];
-    u32 environment[17];
-    u32 reserved_3[15];
-};
-
-struct bootcode_block
-{
-    u32   id;
-    u32   summed_longs;
-    s32   chk_sum;
-    u32   host_id;
-    u32   next;
-    u32   load_data[123];
-};
-
-#define AMIGA_ID_RDISK                  0x5244534B
-#define AMIGA_ID_PART                   0x50415254
-#define AMIGA_ID_BOOT                   0x424f4f54
-
-/*
- * The environment array in the partition block
- * describes the partition
- */
-
-struct amiga_part_geometry
-{
-    u32 table_size;
-    u32 size_blocks;
-    u32 unused1;
-    u32 surfaces;
-    u32 sector_per_block;
-    u32 block_per_track;
-    u32 reserved;
-    u32 prealloc;
-    u32 interleave;
-    u32 low_cyl;
-    u32 high_cyl;
-    u32 num_buffers;
-    u32 buf_mem_type;
-    u32 max_transfer;
-    u32 mask;
-    s32 boot_priority;
-    u32 dos_type;
-    u32 baud;
-    u32 control;
-    u32 boot_blocks;
-};
-
-#endif /* _DISK_PART_AMIGA_H_ */
diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
index a0e7be08a9a..e523781f94a 100644
=2D-- a/doc/usage/cmd/part.rst
+++ b/doc/usage/cmd/part.rst
@@ -174,7 +174,7 @@ Examples
     varname=3Debd0a0a2-b9e5-4433-87c0-68b6b72699c7
     =3D>
     =3D> part types
-    Supported partition tables: EFI, AMIGA, DOS, ISO, MAC
+    Supported partition tables: EFI, DOS, ISO, MAC
=20
 This shows looking at a device with multiple partition tables::
=20
diff --git a/include/part.h b/include/part.h
index 15daacd7faa..eda4ee1b54e 100644
=2D-- a/include/part.h
+++ b/include/part.h
@@ -26,7 +26,6 @@ struct block_drvr {
 #define PART_TYPE_MAC		0x01
 #define PART_TYPE_DOS		0x02
 #define PART_TYPE_ISO		0x03
-#define PART_TYPE_AMIGA		0x04
 #define PART_TYPE_EFI		0x05
 #define PART_TYPE_MTD		0x06
 #define PART_TYPE_UBI		0x07
@@ -35,7 +34,6 @@ struct block_drvr {
 #define DOS_ENTRY_NUMBERS	8
 #define ISO_ENTRY_NUMBERS	64
 #define MAC_ENTRY_NUMBERS	64
-#define AMIGA_ENTRY_NUMBERS	8
 #define MTD_ENTRY_NUMBERS	64
 #define UBI_ENTRY_NUMBERS	UBI_MAX_VOLUMES
=20
=2D-=20
2.53.0

