Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78001C61DC6
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 11:04:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB46A80DFC;
	Thu, 27 Aug 2026 11:04:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a-SiTuRZHP72; Thu, 27 Aug 2026 11:04:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787828670;
	bh=oB4le7kgQ3lGZx3mz09++bmAgMCZ9EEFAsga0NhSNK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y5JA/q/mt8cxLBk9GlrTc6w/tA6v6b0Crl+iAeHH457xfTPKuOT4fvkSUIQDHgdcM
	 Y8qiDlo4w4dgVHsAA8HpHzBdnEp3dlm66M2Ppfqn2cdEksw0o3IkMZNrCOedMxtovp
	 /35SCcbrtwrXjs43mJUATCzG+DWHw7TO07lF8cTvzaKyIy8N4LOitqpQE7zMzk0NKM
	 G5ku60teTgwSmcFdgZJZzYt/gHBBd92FkhjCKKWrHRbdauyqjtfwHcUWL9N6qBmyAd
	 z7SNAxsvEfVL819MCZFfjUC+cvhZrZfa4gUPGC27VJpbPwp6GqFJhILq4DFMxBQbVb
	 q2au1OU3+57Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0B5380DF1;
	Thu, 27 Aug 2026 11:04:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 467D1334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 11:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 26DDC606C4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 11:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CQfdr_CsAF-J for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 11:04:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.21;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=LvRb+so3
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67F01606B9
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 11:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1787828626; x=1788433426; i=xypron.glpk@gmx.de;
 bh=oB4le7kgQ3lGZx3mz09++bmAgMCZ9EEFAsga0NhSNK8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=LvRb+so3e+86hvmukOD8iLAkvcya9gvvLsW0BmoxzddRYQmiTsU3tRZPdm5fTVCD
 avWSiHh7QBeRkmpficTO4fDaLs0qdX7gr93c6hn0g3UoGTgEYgKQmCSgMVkC9rWQ8
 QiGOxUBk9MOaV/WaHlqz0LPc0kmdyuf7ptew9faNew5MqD+aCxNos0ZKmaDhhXzx2
 5J1PYlm5n38Mk5yDzGUlLFZd8xHEeUHLKM3lRs7DZRYEmrQSRAyyL5WiftW4L6CdI
 CQiuwV1uzagAJRp0m8h45JV0vH3AKiRQYzg0DSbp3iHJYRHalopQLrSQ7A9/qZUq1
 KKi/hmd26pG2kskWyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1My32F-1whrDi2Byx-00zwrr; Thu, 27
 Aug 2026 13:03:45 +0200
Message-ID: <a2b54c83-97a2-4b81-9c6c-6be32f127985@gmx.de>
Date: Thu, 27 Aug 2026 13:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 00/45] doc: fix some issues reported by linkcheck
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Viacheslav Bocharov <adeep@lexina.in>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Soeren Moch <smoch@web.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Le Jin <le.jin@siemens.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Peter Robinson <pbrobinson@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org,
 u-boot-amlogic@groups.io, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SAU6+T964MwcNYDwmX/nWU+Rp7Y+GY3okhCLZYInIVefns28mOT
 047eKZriGK4S5eCJDIhYFLBAfXzckaggqzt+bkSAzuNd3efBFYYMtQHCniuKpUH8bSV1f71
 3DB48owpcAt/kNLYyyg+rK8SeAtUsNs4DbcEfmM6eIwIjq0YIsQC34yLv4wuCA2FjVLxlIJ
 rbGqESzCcnfVLVXWaXxYw==
UI-OutboundReport: notjunk:1;M01:P0:3C7/V9ErdXo=;saF/5kRRv4wlsAe6LisJlBQOXC8
 fIt4JgfRT7LQjb4Pn9gBRSE+jKWG/3zCIC7RnnmYTpRAXllOjoWKPFszbvDB8q7VkriY4H6gQ
 kfCpf9oQtXJH22jmUNYrBrma0FAcY5yiVMx11T1Zuad+h7+f9adoqqtTispcN96l+px1o+IF/
 T+XUGtNgVxOrmVWBE//R5Jn22MKUNgd1QZXyL6X4sfnlHwU0HWOjWkB7kus3hd0ssatfmy+oc
 /i+2dRMh20IgEukaSVMCbaMvhDQZE5R3oayKNqk39S5VsK16AsCId6bxzgMpdEnZMcErqcHKg
 pQ66j2aTMtTo/Ud4zpKhorTqWVjxbCPs+h24sIgD4eF+nsrfv5FDe4wBVxQxcU6y2v2fthL7g
 mP9ODbvd2pBtRwL4AB+62rE14q0YUAM4ju13EhPmGMPnPbq8fl7zD+zQvwV2ad5yYG9Kh0cJD
 rUZY5EATROkyzfLtOBTKYxreSLmngSShuh2Jo2lzpOodnHbVem0ID1mphLdrZuC1wuKDUzBUJ
 hYPNwNvPNmkXNC5ObFK5096TQfAYiY57OPjBPL3bOZmf7wmnzuD+/WKRDzgkjxLaVnvybbOl5
 Pp/Eg8Y8znrNClyqMGi+RTMXTDHG/LmJckRt7Yrkjq1YthyVWvTe/NETG3LT2aXqqrMEZOxt8
 J0Z4gKNnWvMwqZ8owM9pMoCzfZOHKLLiunUfdCxh/Th/fx1ySMSIZqw29osZJ1B988kPgQ/q3
 1MSBkNFiPTIGW1pj+vV+2aHooUnY4GK8BlQhT5Bk0MnDfJ264AhLJX3xdZa+QpEL0g/0mqLAy
 216+Sf3SU06LAZD5ftShbDIv4Krn4eYKCTAmZK9K1kL8awczUSeDfE7E2Q8uwC81amEfTuKGc
 R7j448QOvZS5G7Apr2gBgNAJoLsZ67Mq/3rFyLJNlbJdUmy5iOEOmv0TY6LxTpDdm5LGN3rll
 XHnEWtOjZC8m+nnTbccUlmkna06JRSUxM7PbFat7NvSEp8TVaTi/kFkAFtuQsa2gsRpRfsHDE
 IxyJrxAX329TrbZLHuFtfMyPeE/272RG8kWIT42WDR6HtRlO1iDkk5q8MUYUVTw3k0zj5ijf9
 N2KHnr1we6UhYFKOPyViAaQ9A0gtYDaEErIOfncfCCBbRB4XDjEGLY0P2wHUyu6QorbcbiCGn
 Pmv6b7ZbfhFT49ycct8VBH2Q/D0KNbL9J6HhClrJeG8GGMhQMQwm9pHIF260OolsFF9InMHmv
 2nVvDpmKnlZZqDpeCQYYkUfq94LD6lGkxkwcFqWIWR8xFx1v1DddnHA0D8+LtlRzzjAd0iI3W
 nY/nr7n8dFMr2CEo3qYfqJXCWxldLBVB2847EPOmtN2Se1bvGg+Uf6RyHSmxwm3JJdVit4dfP
 Vgymji/t5MWuZNQMmO2UW+S7xZABL9QlKp6e9poBHn9Q0QTZqClNM9tCbRlr9xSzmX0z8E2b/
 WLsq95fP9Py8PxGvg+hy3TMmbHF+pcjNS33l13qHEsfsMQ6zSaCJeP3Pp1CScxzpJ2reOVP7i
 oHbF3f1GLeNM+70vG+f3jBH71t4umyAbZufQsK+xrEQmjcfGVfROI2YqDisavdyZKeUtpmCh4
 5xtnPFlxs2zEpvmwrbjpiIiwU8eOogobLcwm3/qPcLphvxTCHXfh7LkhXg9JZQqDMzEjJ13bX
 YULm4FTNBpg2vITStxKGVZgNgEMpU/4Sd0C+V/VZ8+ZIVeggEsYFwLYmGBrxOcTdJgZM7VCiQ
 KMt9fhQ77XUfYTPCTNethenucbMyeE//rrNIHr6sF/ReDTtjgWT5RSysHDmpA34/wg47AnC0l
 IdUn/BJPBoqiHvUJQZ536jDEOqCOEw3xM5kl+WZ7awZWEqr1Qn8psTJmiBGYoxF19OXbWTVBa
 lHQxf+f/iZUDqWud0RIH9qRMZ4WHM2WxoTz1GU+5jrXEolzSvYHZwrLmXKF8OJbsfhfK+N63E
 rGFlYl1ETVG4UAHdYm2f1a3MsXrOj7RRmRC0R4VZxt6e59M7xlyfiFNeHwqXzEdX2aAZrZw5R
 k3jBCF36DEooXPqThoXma+eySFHqH9/skfC/HOhuPiIdcMH/772YEKa74HXB5jFsTl0Jo3HD0
 qMC6E36UJAqLKpMxqeFOd8DwQts/BX3uEYYG4DrkXHvUfHSmPzoam5Ku3k1gMtG66frPFdYQr
 7YSfGsk6h0BMlsGdnTucmyVdGsXr8cksnTGy1YXKkNjCKGU8pXEhVek2i7MGIpqWNWtIrrbGC
 i2MUiQLCATKtEYHUYMkYXhAi5gtm6XsK5/dJzBo7eyUiYA+d4MP3qrPNie+6k0+DGHueuCCMI
 386AZh3vKDJ/rXvmcR2YG6uah7c5vUhTn3Ep0an4N16P7sGZwWY3ma6V4m0VYpBlGYq0DGljE
 Xh7MIVSYcPu/G4dUR+vNSjGb31U/EHfuuIq0k+v8xN3sojqIpenE/7SGvbsvvbGzWiIXbTlIr
 SxsLCSsn72jD2nBVjzndmz1+bK3/6kOf/sHIoqfESs0Moej77rIgPVignthNtObngyvQs4SWC
 6CsOKkxGXdGkbddubsob4POYsNi7OLvPlIpNgBRuqCrV1RnWU5oHoybvALz1wZTWkixs9TbsZ
 gloPupks8VHhfSZY9m4T/4EjitUhsecSdeyjgxmWxxyzucIcqB8jXNWBzlA5MPZgEGobbU6Vt
 pzTktTN3BJED+DpTpTDfpH0AtPFm3yjp7EWJigrashgqKA2i2Il7gucqxOWEIB5QZqo5Guvvs
 nUYtcTik5Mg2prklZhQloN8ZAXrs7fAdM/InEkhIExCCBL/nAQLQIxOiUp0yOaLL05O8U5k3m
 Ykcq9H2Pa7EGzaBh6NhGspa6Q4YysM1G4UIc5bQJUi70MKmVNsejlg2KSLcCvJsxUdIvE1KXS
 pwOM1WBtX7ip9oMsbXq4RfFoNgFliKrpHVOqwcR9Zrr1+knJ4uwdtb+8q4bDuo+EaOpi+sQqN
 HUvFsWV3Qh1+ZTlIC9+2bAG3uiJO11YgZydIWFs1wKwD40KPshijSrZ4E4qmsggKKWvQxLoRw
 hBygR3i97+1KxTHTw0C0jHkCcr44j4PqO/jhvdiLk8QizEmEWW1+6BoT/QAna4Hqqh/YlrDP1
 bCKRHbOhUCjSC87hkCn4x2LJGyfZ2MI5lj+2iXIzN2TzzyRQfzbOZbJrA0yp0fwB4WxKiq9No
 HPgjflgP3ilHLnPHi4ZokNA2n5gs5qp1fMf2Go5GuG0Jt+SUloWG4fcaVXT7fps54rrvl/JS4
 xwn+nIsY1WmMXl6A+ESY2UNbRBv4XEYXdGTpeFLPfb0bWeTKdIJAvKxLuPN8zjureH50YyrLQ
 aqjS+dqO2dQs6pDSG5a/bYkTrz/dvYhU0A0bdpjPxXVUBBP4Gf4j0RC/YWpfBLLyzL/FkESsh
 cprmyBwbilxf5gVOAwMH8U/Jy3b37J7Qu4KDTCgWHZXAYdQZSD0yy9KZmn8hUhbzCBj/HxvFi
 5yUzk71K8ic/uZvIwB5YeayN5tJovzWDjDwlkn16iIhtO2p0wGbBtYEjY0JpxyPO04PsW+1I0
 dbnXU5/QwkaEduPYoyIMGr3SvIC+dzkZKhTepLT4EVMvH/VeOM0kjMPDJdEUnCkWmiTbofM8m
 jCLzRxlTMxjaCcuia7QXIQ634IQD6XSHBjIGOh/r4ogZtZbi0Vyk7XH1c+dFlmbPmawZzrlhD
 KzK5kzRDaEn7DfhJ4VUbOy4qT3iUKuNezXGvGP/9Y3P2uZ7NecY9f8Cjar8Abm0X/nfJYRHAD
 oU6/r6nHSlCpxx/OmLoILQTL5bl4oXsbcwytcZYidbgzqUmYLCRx/EDaVCauese7GlyQzn22X
 BlhmioB7T3BYsHQ8rF7gdfkYRUmrY//9cn7HkUOOiScnPKvYKlrDSGv1qr0/gLQwd7xoAfUbb
 /kwZzN1JorNxvMeNf2ZdfSnh/p63dBP3Cc4HDzSVch+AkZhdckLg2cMY+QejMl571Q4rL++0+
 CTa3bAqSPXxxQrFmZmpk9cUAfTTZit/Tn1sR9YW6A3FxQ1zZyK7tNYx+G6QzW7Po5q2ho/357
 6id/d2La1qKXiU/hi8iYqFckCDfmuWRfPr1eITyIp6/K2RcdLsnCRfmxzbeKotpFr/BzHv4hK
 SjE2t8vQKvkSCsV6OUECxFc/wkAzAIii0TdUP7BRiiqBMuhOQP1uZAm3q6toJh1NtdUmNXbDg
 HK7MGmgwD+O1BQQZTXXS7M3WKyludCdHafZ3mMrcvwcwbIhgK6Q+AvNsYIt8YX9ASif5E/PMT
 YjhqJreb5qZHurCDNMZSSvIaCgcLIQPHZHDEB7sutxK9XkzgarUA5+G4OVGUHrOIHUEh1tsqi
 Ry5poFrLACk20DzbrCVhGLMmJ7Q4Xb3jPhqFZUZK73hzb2wGHyk6mukopPYYh5PIcjdNG/QVt
 mYJCGG+7jx9nwHgRafbTjDAn8VIRttiVmhb0ZBt/S7fb6n9PcvL+DBUsJtTilpfwfjqYIPxOd
 62k4nUbxgMNvcVpRmuQ5pO8OnAa1LPxj/DrE2rdmDb9JdyPzi0jbJ2Y+z5tLRFl86uSgYPBDo
 xMyISBO80xVumc6syeHgwUDvXseedJkuIrtdxHZppbbEBmNivkWR0GYrOwBI1KSozHQUp6xPJ
 gEMEerRjfu/YutsAxCFB3uZSorN/TDbDJmUXB6KUO/SvFccx0cP5GbtOVA0jYwxEUDH03LvyO
 iHZz+fNtfvJYjP7HeTQOAd71SPtfuIbiAttHGME/5n3lgPuPEFKVIA8SjfcF0P6HdruPrpYSv
 4dfzIAipmsvDkGUsACpHr/iMoy+22d0Fj7xS4bUVLQcByoxeXp8ZwhbdnpInfrcEdJtu/0jG5
 AjHwu0EGnzciy/IAnFsXYzwrCx3ixXG+KQ6c4G5iz3feoZOE9UmIy+JlakRLXQEmTiEjsK97r
 etDj1PMWzPx24CqRF43V7uH3YjenV/jgYaUP6sh1V5ES4q/+vAHNLmzieaivzo7Erfz0ZjOJq
 tZ5rD8OPU9H6coL2Da7D4/YPjilqfNKYJPv5v5uoyZajzwZCyW+8Mw9vUzf3fz+Zylb5OXlbo
 /xkr3SjJmQKiq0zn5aCXL/YSVnVqnPon3lgiP5Ql+3Pa/ecCa4aGRYkvynRliPhuNC+oXIiBT
 CawQpYDo9YgY4TGl2VBlXz7Gk2bMR8wfFrL7XU/GC2lvDRZXe5jPxukouZYUzXAmdUbGxk0z4
 wGH/wb90+CfTsCWFKz/8DVDtYFgVdVILFrham1X/eF075Bl37bhtW2C51MDj7qXaqW8P4lQjk
 mf5WpBkTd7kfYKe5qN6350dCIzNVMTO+s3rK4fFD381QJFflpzuFIW9NhV/gzoHGTmWRmeh65
 fjeKrB9xf6IfPatETpDM4AWT4aRu3HL33A+p+pRQzN0lUVmUpvo2jASmY0DWifceS48n+xR0V
 PYDWcpcmZBKBS5GRBaFh77tSb9T8LTtmpvFmDms5f+WShtARhz9dCa3icBrgU1EQ+0O9MPEUX
 C1YN8+/8aDR0MjQ/dCgVD7WcTuPw+5T51CvQc8tUNpyACLf0pZ6EhrEzllGKcoBRHjdBZNHoS
 mOU+K9sCauttv8wlpP6DQHCyGUCgJEOHAeYqWNHA1S8eSN4ILkOkZ8PAMI/KmjWQ3kGquDdEq
 kZaiAYZgskVe0Sf9Pf0qKC2TfIKapEn0JhsbFTMtOWVMbL3A8toxtc3ZlHDCc4Np5dQqRqtlq
 fAApjOXRIyPyx6xOEQt0fLSG9RajmUU3APfzxeNx8W9A7q8aWrj+PuErl41c7rpagoyxSKakN
 8AWxCdCphJyYyRKI2AY5B3vLyDDX6vle/gZJ398vB/pu5SOou+fK1J0VBNFri2Amxe3vaSAwe
 AOLzKr2PY276VWVrwE43yVAY7xrnoVlcBWQZr0xNlJOjil5owtdBOyb3T1kRnW4kYZO1WbRmT
 kVn91M0ohfzC7ObWNorBO0kvmUl1GdiH+IjIk9CyD7Gwb5rydptjVl+kPefdSJqm6v9Vhc78w
 zo0RSL7FiFbnISEYA4sZG2QxCKLXQD9ejhOfQHWPUdlKX+Z8f5x+r9LJPuYAXu1d8Dp2bGoaR
 bb7fdRjnG9UiiAUATJHAgG8WFZG8/St6TFrUCFEdhNGryeV7hvYwaj6ADuOKiAezEbNca6gk9
 djezkXnM9HhEpjPHWMnCsE22cg9C13ZvIYhcktW4UiByI+0jZ1B9GPrQiPCzSXrwE7npB7I0V
 dFuiC7VdskzGtmTLjd+DExPsQLFphA+WAOI+eI5sxx2e+aefQpYueM09VZzpvw4ku3nuBQfzq
 yA9erWBnzkuhfLTA8qy75KMynPdkF+2tTZcZVKsvagcdqHy/hU+9nENYX2Aev8XSgAwGJhEu8
 gl505xurPn/dKKRwV+iUFrjImGDKjdXSRcxsfA/CLwn3o5HjnA3bvpwbVumMAngpZ2FjPsEn1
 GHlRAfsCeA8np8QH9i/ndC6nJuJjuueBJmlswtpV6eUi5e/Aa8uX4NVRDJKEv9bHF0iKkt4mp
 ceBSN6O2xs/Tnqkqj9ZUd0sDaXY733HjXYCTvhu6cDT/7BRqLGX3acagndGhH2x1b4lBN+SeH
 GZngaxnhXFyxPWS+cW8PcqJtjFgu26qUH5PesGbjdwOFFcCozF2fI1D9Zdm1KFxJ2mQE3Qid+
 fnqEuH808n8agniixwevRzsiAaZ1UV3Z1qVHssAFH
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

On 8/25/26 18:49, Quentin Schulz wrote:
> Saw a dead link and made the mistake of running `make linkcheckdocs`.
> Now I'm knee-deep in it and cannot ignore all the dead and redirected
> links. A day later, I've had enough so this is what I managed to fix in
> that time. There are many URLs still redirecting (could be fine, but
> needs to be individually checked as some big companies have a tendencies
> to redirect to generic pages instead of issuing 404s...) or returning
> 4xx. The issue is that those 4xx also need to be individually checked
> because since the AIpocalypse has started many websites now have web
> crawler protection in place and linkcheck will trigger those and be
> denied access (or be heavily rate limited).
>=20
> Please be mindful and only run this script once, save its output and
> work on fixing individual errors without rerunning the script, otherwise
> we would only participate in hammering websites even more (linkcheck
> runs multiple workers in parallel and retries when rate-limited).
>=20
> Note that linkcheck doesn't check for links in code-blocks so our
> instructions may point at dead links also.
>=20
> At an attempt to avoid tens of people running linkcheck at the same
> time, here's the output sorted and filtered on !ok status:

Hello Quentin,

in patchwork.ozlabs.org, lore.kernel.org/u-boot, and=20
https://lists.u-boot-project.org/ only patches 1 - 21 arrived.

Please, send the rest of the series using

=2D-in-reply-to=3D20260825-linkcheck-v1-0-ee7573fe3a4a@cherry.de

Best regards

Heinrich
