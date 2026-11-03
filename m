Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E91606A328
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rSZi56gr;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8j4GD22
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CD6C40704;
	Tue,  3 Nov 2026 16:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrS6OqQ-ek6a; Tue,  3 Nov 2026 16:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 373D740687
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793725086;
	b=MIA8PhHHIvSFQZXi+PPY5MGn9ETZrSry4Ecit31ZzivojObJeNvN9tctCUZ1vMuvOEdQ
	 G1kHBjKuxWK5zt3b27O8PqIC+W3YbWSNXxX6dCAgQvBpmFL60GQ5pFcHO33bZVz/4CTre
	 hpwroClGrVNyF5cvU4/TTgOelFCmBJD1wcJE8uqtj221p2N1y1avzJpZ37J9X+3AmcLWS
	 Kq0p7ZdUsvaX+29P0I35ZyVrgeqyuIUqDLsxkEX5BTYHv3Q4r0ESW9osvhHPlwX8P3kYj
	 geZO9IzqQfkM6anG7X33EC073um70eJVTWHNvl8Zkj3XLas6qb9MrwqBpLukcKlR8Tg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793725086;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kR7uqjdkm96G1IabGSX0TdurfPwPTDoryLvBgL9gcRI=;
	b=s2UI1/segO1PoIS99NK2PO4b3YdwWBiJCIf+wV5m6AVfDFok4RSV5SyYkFjuRz3S+0/7
	 VmUo2zYV0MOUkfu1SRZBKHHvPqmewZbdMC3RGsds3a81c3LC6uEC6Qes0JMh9qorYs3C+
	 cLMGr2/5UOYbLW/54/5MpmoF0boLg/u7pY3uRuMHf38kD6C8hxmvYDioWIJqHSEY5fKAR
	 mMArxH+PWedcPpSJT1IBDycf7NzAAhdjlsIcsV80rf0heHciOny/JyJZ7CulBoFVztIqq
	 jhORW2SoGI2dX1SwQIY4l9pUjH/lIs1h+I6DWgLzSRQszPGyS5F2TQKRn0RBP8utKHw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l8j4GD22;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793725086;
	bh=kR7uqjdkm96G1IabGSX0TdurfPwPTDoryLvBgL9gcRI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rSZi56grjouS73mQ6SE12QTPBSreHLzMIz3PT9WrpZvg9dITppQQWnK5DZShD6Hz8
	 /dv7iZAFkgactgIPUjY1MHWOtgDjgE9M8e1Icv/j2q6QcGTskqgTw5wDYaOiZ1hM+I
	 De65eIqlrA1Q/yZAMg2jIzVaH+Tln0NaAZrHtupxlVaSxFk8KeYW3ct7dszJ//HPma
	 LKhjfRrOea6Xyb7UlKOahKMcrkIPJEBWzn7R/gGJ2/HwTGQ8KyoBzb7v3eZPHlPzF0
	 wIGGqx2Ui5lV47kbmaGrxQZWgglICkLjgR05l4V2QqCz7dLU2UT65Yth3jlCAgue4S
	 mE2vzHBhJ9pHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 373D740687;
	Tue,  3 Nov 2026 16:58:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83CF14BC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68D2340687
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oPXmI-0_EI48 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 16:58:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F6D0402BB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::834"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793725083;
 b=UbErVSCEbua9vgfwH42/6/9GVQyIy3gvX1SpkG6KMuEH0E/4txhzoNUbKAUeSIRos7B0
 BL/WCf965GTaFRuW0li5jaXhbh6NLFq9SIE7YuCXV4Tf198LsHWYrnsqFrPSK7TiJamwk
 uXVrgbEF+oXAhxhsmX6gzOCC272Yn4hJuq7xaPIPTHEyinXC4DX7tmtUW3W+aJxK3pJc9
 1rvXeW/ba9py6ySN+OkdgKYH8sUdoXcUpelyAq4j4z0LrrX3ei33Js3wytyT7EvFmf76Z
 YoQaGte9DKUsPrOsNlXlaMUtzjMpUctt/DcL9ZHyKzE3d3UDSyORTeD1qHKzZhGvAUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793725083;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=kR7uqjdkm96G1IabGSX0TdurfPwPTDoryLvBgL9gcRI=;
 b=Rk0ExwlFAhsVWcjmf4j5xFIACFcTfVGObQt/ojFnles7ii7vEYng+OAKcoAhpmDTQWya
 mBPF3nAq0Hsb8yrbSXgf7E2aYl155gmCRi8Ohf4vE8he1xl0b113wrWbA16tQTbaxCMII
 hmZjj1Fxpyklouo2JEHTXN+J8UQs69VC0Pjkp0Md18H9LeCYnOLH6Tkk12DARW4jn7lTM
 gzGVmcprD5KGo3dc3imCnGFYqvVEnfDQ34oNzo9VOARKv4dDGyuZM/quDQiUaXdypfRGV
 GoIxsL6ACOq/K0vPR3dpCC28qnx38hbeEnLC8wIsOoxN3P0jGa1Vxn3nnTg/Gpedi/g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=l8j4GD22; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::834"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=l8j4GD22
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F6D0402BB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 16:58:02 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-5364648ae07so47061831cf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 08:58:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793725081; cv=none;
 d=google.com; s=arc-20260327;
 b=F5Jt44k4+LHBVDPsviZASzPHV5wjbRT2Hl3+/CaXncDXgze9zpywHYxWgqp7EaIeid
 kHPP2Q1KiaWF3bO61FkXU8vsWZgEjabHDMUnqlSsLTq7H6Uo2xYdFK2udJBWDSGE8MS1
 5WdIZZ6XjFVrXCWrm0qQtV49cF7/Rmsu7g/fibSiCgAskSH1cEaIuM/9pf6jGTeVXrhc
 RSScItyeNA4qMZ5WAg2crpimh+Lmg1RMuuVK34PsKPFKWRZ3LT4l1CEP4xd4FhCdxBHO
 addg1rMxdXh55pLNuRqSAk9GNATr7qZM3sk7DaajsoSQo/O/XBdsUYoWspreRtOALaHF
 iauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=kR7uqjdkm96G1IabGSX0TdurfPwPTDoryLvBgL9gcRI=;
 fh=twFhRcI1fDJV5kkgpGcPxHjDMMjJNwVOXJmMdZZzhP4=;
 b=pXjgFU0wBo5RAoMbmejxI4GZcXa4ITlDor9683u8QlAW+NWootnxCRSRDcPzMKk8bS
 qKJU1YRHwKhwUC+Ks3mcDls82b4aeLEoyvWs476zoEBpeRBB+0IYtKXNcSnUa3RbKgFP
 UsIl4p2Tdbg+2OiRziJCxGeBOAnLmaFKnU6NGo1UAFbigpbFol0IcehNsscQvxBnddHx
 3XGYknJWl6ALW/4UYCMo3v93/ynYiGQhq6+g51foMGFk2x5PSVd4mlFMV1QkdSaD5sIL
 4G56un07KVATGOc21s3/ciZ0Lw/zcBGMbSi/JifDOMZrvQRpcNDpXO/WNsmPWFNlXeO4
 sX+A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793725081; x=1794329881;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kR7uqjdkm96G1IabGSX0TdurfPwPTDoryLvBgL9gcRI=;
 b=l8j4GD22Om0kNh9fDG5BSWlz1q0lOOpSAMnyXG8yzJVQ7+f5vln5w9hANsXj0L/B2D
 yBi35alOVW0nrMNoIvAYmfgjy5L7yz1Mjfyjxr/2F4SA2PB58E4X0lIXekVtLpAbdkny
 ZOeRv0YBi8z5RBtJblOqZXb+MflYHB+hVPZOyJIYmwmPm0ciEpFWmKJoL025FznVL2gF
 wdE8oXH92xbLcOd6aW4G5UxrGl2FqYlL1X+jHW04ncP05N+Zxp/RfclVlDvU7xFmQh4p
 Hv73iT3Z2HIzS97Q7El60ikeNLa+yVmZ5AoxYzc8pVDOL4G7Ioi+mxzZ4iAM4YX71jBF
 Ikww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793725081; x=1794329881;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kR7uqjdkm96G1IabGSX0TdurfPwPTDoryLvBgL9gcRI=;
 b=n3MbJ3EXAww0EAH/12VC17U+tcadufSALNsezDCV+4c8B614dyUFx+LCKKjcEDyLr4
 6D5h8EDLVe4DJ9Iblw96RcsweCL/oJnyGPOrTzl1B6cf+S0qNJmdcSGTaqxC6/YLVbpJ
 PHF39fCO9on3NWBqp7Z8OOkxHe9NIAUTOQoIjSJLqpHLSVBtXy963yLE7o480EuRh9XV
 m42A2VpEjMw7ubQH05E+VHusfNtbmZogVUIx7MYLw1d6FaMq6Qx4fbmTrI/vNQNug/Xf
 n1SUvbQcgvDGPYX4QHe03qVb4vSX+LGjze8S2cVs2GdjQyNbZ0KDZBqm4W+KdkQPXipn
 GvKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQCkFNfsrXsGZ2MdnuRG6K/CrWw2o448yNaSfA2LzUZj2Al26q+OjZDDXW7D5hTLgJPtNjACE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+LE+mw7EKkbrn+9mSiJ59trTOASpgivxxgBVyo9rwIZMpaBa5y
 oCM2TTrafMn/iBohFLe4zFlN3uGyfA96S2zdudv4c6OGiaBv+2ULbtfumtg4AXsUgmFesKb5a6M
 lP/dHvAzL98NBBAYn53x4NGZR5PH7sak=
X-Gm-Gg: AYBFou2stTfCSlcfQeJmH2HNwQk9nz4BSmvB3ThFupU9/EXjF1Mw7WB9gFjNdZ4JgAW
 zdSafV5POYZqh0FF1LOocdyTBIS7VVoeNqTLNfRyiuX0psFdjXLReJRkxYteSu0V+PyBDM01ZZE
 Ydfva20jiz49GVT3cdX/iwkaNgPxDDjF5ck1CCqf2xfM3IwS3mQVJiyoyPWuskpIG0AnSSy18Ur
 m3k40KfKMvZtVuzJRtI3jOUQH8ojVVOJK7HYoUTc5bY0Dng6GPOSdnzxuG/DyXPa8VkQDLce91S
 nFBOogoWyJ02G+b/Jyt6mgOMAzCZ2Pe5s6Pthzyo3dniUfN7gj1/NyiInY2YklFy2JNVC6r62/L
 xQWNAwVEoBeRlPWOcvrpysh1R1q242KHHeS2sKii9lnB5T4+hrM2R0vrt5jivTPDD1471WlQOkg
 BAWFDHuROCrDaNawWIAt0lD/ZfichFlUi241+lXPSot7UAOftpR2GxhMGwv1Npu/i9CaH8AzL8x
 dZIMksqJ5bYxOZh0cFcfPqGfm6mmJrTeiZt4AtQLpzz7kl4iM0koYJc
X-Received: by 2002:ac8:5984:0:b0:536:5938:bf98 with SMTP id
 d75a77b69052e-542b6781ab4mr225804961cf.20.1793725081542; Tue, 03 Nov 2026
 08:58:01 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 3 Nov 2026 16:57:49 +0000
X-Gm-Features: AclHuK9h8yVmih8HWPkEtLvZGfmm8eOkxDo-Hhgt36F3Qr0L-35-Tba53hNsS0w
Message-ID: <CALeDE9Pu2rzu_zaWr=XAux88nV-LJ9_AYfLB8D6EECgm-BbeCg@mail.gmail.com>
Subject: Removing Simon Glass from the U-Boot community
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: uboot@sfconservancy.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Community,

Effective immediately Simon Glass is no longer a member of the U-Boot community.

The PLC has thought long and hard over this decision, and has spent a
considerable amount of time over the last year behind the scenes
trying to engage with him in good faith to address his behaviour, and
as a result we have not come to this decision lightly. We are well
aware of the considerable amount of contributions he has made to the
project but unfortunately the overall health of the community at
large, their contributions and welfare needs to be prioritised over
that of an individual contributor. A project is made of many people,
not just one.

Over a number of years, in levels of increasing escalation, Simon has
engaged in unacceptable behaviour to many members of the community.
This has resulted in numerous complaints by the community, members of
the community refusing to engage with him unless absolutely necessary,
and a number of contributors leaving the community. I have personally
run out of fingers to count the members of the community that have
made complaints to me about his behaviour. In the past when these
issues have been brought up to him he has chosen to "Take some time
out" where he has disappeared from the community causing issues with
the sub systems he maintains and when he has returned his behaviour
has not improved and he continues from where he left off as if the
rest of the community might well have forgotten. We do not feel it
appropriate to go into further details but it's visible to see in the
community's public forums.

With the unfortunate passing of Wolfgang Denk it became clear the
project needed a new stable home. While the community was discussing
the options for what the organisation should look like [1] for the
U-Boot project moving forward Simon decided, without any engagement or
agreement with anyone within the rest of the community, that he would
engage in hostile activities such as registering his own U-Boot
charity [2][3], filing competing US Trademark applications[4] the day
after it was public[5] that SFC had applied for a trademark, and then
later withdrawing it. There as far as we could tell were actions to
ensure he had the ownership of the project to be under his sole
control. The PLC only discovered his actions when the SFC alerted us
of the details while they were doing their due diligence on the
project.

In related behavioural issues he has repeatedly refused to hand over
the u-boot.org domain to the SFC, the organisation the community chose
[7] to hold the community assets for the benefit of all. During the
discussion the PLC and SFC was having with him to donate the
u-boot.org domain to the community's chosen organisation he repeatedly
tried to link the donation to what we regarded as untenable
requirements for the PLC and the community at large, such as
recognition of his personal fork as an endorsed U-Boot
variant[7][8][9][10] as well as enacting numerous delay tactics and
setting deadlines that he didn't hold up. I had asked him to get
community buy in for anything code related he wished to try to achieve
rather than link it to other unrelated process.  We don't believe that
holding a community asset hostage to get things your own way shows
behaviour we wish to encourage in a community, nor do we feel
promotion a fork of the project is the correct approach for the
community as a whole and would we then have to promote other forks?

As a result the PLC came to the conclusion, in consultation with the
SFC, was that the only option available for the health of the project
was the action we have announced above. The decision to name him
explicitly has not been taken lightly, but we felt in the interest of
transparency as a very public contributor over a number of years, we
have little choice.

On behalf of the PLC
Tom Rini, Peter Robinson and Neil Armstrong

[1]: https://lore.kernel.org/u-boot/20250225164121.GP1233568@bill-the-cat/
[2]: https://apps.irs.gov/pub/epostcard/dl/FinalLetter_33-4591093_U-BOOTORG_04152025_00.pdf
[3]: https://web.archive.org/web/20250922201801/https://u-boot.org/about/
[4]: https://trademarks.justia.com/995/73/u-boot-universal-boot-99573698.html
[5]: https://lists.u-boot-project.org/pipermail/u-boot-custodians/2025-December/001573.html
[6]: https://sfconservancy.org/news/2025/dec/29/u-boot-has-joined-sfc/
[7]: https://lore.kernel.org/u-boot/CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com/
[8]: https://lore.kernel.org/u-boot/20250227201523.GJ2640854@bill-the-cat/
[9]: https://lore.kernel.org/u-boot/20250217191826.GU1233568@bill-the-cat/
[10]: https://lore.kernel.org/u-boot/20250425001642.GR5495@bill-the-cat/
