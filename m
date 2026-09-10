Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACF2C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEB3680F55;
	Thu, 10 Sep 2026 14:58:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Mwo6uyu4JcJ; Thu, 10 Sep 2026 14:58:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0750E80F11
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789052320;
	b=TDhxuyf6I0Qm82r1lpqYW5WV1Usekgg//Z/y+upiKm2HGoQ3FUODTPOCgwOIGT0coMNy
	 QTRtJzrsBFwxJ3NNHseerqHnsHDLSd4YOISMTtp5yk2k1Az1S4hfwn6Gb5/uBTeML4HXi
	 +1fMF/Rk7s6EqeNCvy3AOsn16n2lFie8ZMTOyhui2af3wph5mzK0RBSOSIDIKzCuZ2P48
	 vomAueGnEZ1QOW7qv5PiYhOK+K1RItkog7d/VJMdT/62XYkZ3K9uoyz501itaALtFcCaF
	 BIRn8SQm5mZjHLxoVmCymUFHUVGw1JXEXA64gtVAhVozqFUijbO8PyzTECcePOAWUVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789052320;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TMgTlKMwxSdtyxXRSQDVIE3ZmIUqxfk0OKwfRuOZ+GQ=;
	b=S7RLqJNZQTAfAAC7noNGs5jrWxKKxInYHpjZjGyu+2Xnzo2VCm+sePwsG1CEweENOgmO
	 JfWKDDQj6fBY9wvcv0G5hxTpeFlUEl0cRkXVl64YZ0007R/9Y89+QFz66g/5LVFQyFnan
	 YIAelnZyPC+s12nj3GXU77buoSiO9MIiGUrJuNz949E+HiUFZwHVvgYR3ezTDeYohUPvJ
	 iuw40nlR5Yizme4eJlGRwI3AXX8v7lm7xxcxejZtuwIW+tkuLQ4OsJw0w2rLl0Hb1Z73L
	 OLSzPOIGMUU4RoOCLBJCyH/cD9DPxFprhtY1bciBoUld3eUh+jd4lc+c2XYXcoaDwuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789052320;
	bh=TMgTlKMwxSdtyxXRSQDVIE3ZmIUqxfk0OKwfRuOZ+GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yQqKWfMLpsCvUD8eQ3CzKPfvEUU5rPKqXnSc4MhHBLGcKKhIq+/gyTujv4dOAnQfd
	 fDolgX0Dy7PKSZ5sxk5X6d8FaKzqtmU8w/qjL/XgIV6ZThfc9DiwWmPgHtjXdloX96
	 ykaS2sG1obDk3eCxV8aJsu2VYyEaPszcSr0z2wnd/O0HNsPYYLaT6fkZyGqI47uxY8
	 yuHz8JPecIbAO1b7IlEuHMP46MEHoAGNn8zinICSVYQn0fFZXj2IDc3MSXEXdiUt09
	 ou5kpSKi3fa9OmzQxIRx1gCom1trAhcl1nrDETo+b+gkCfZ9iwIvRvjbGp5Q1E1AkX
	 11e7+HFrrAhCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0750E80F11;
	Thu, 10 Sep 2026 14:58:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1CD6268
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7739F40AE4
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pfroj-3kB0Qu for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8328F40AD3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789052317;
 b=oD4n3CN10ZkVDvAHTtcxcZYmTkWjK95PI99vLwBuDanehcQXpCgrFq/VxvQCRePhRQ0z
 BzXdIF04Z3drXTuY6yM4KGNGQyWg6lbrWai7KuPVfUGnnv2KW5WiLbJwE282DA+dov62F
 4tyh9/3yhoxTu7vjg/q/z+inuQqu+8BXu6g6ZB8kBtnsdhZQnNO5zHsoCFGmjHNzEhrrE
 2mOzxW1qMynQFfUgzTo//r58fwMOBc/Aej3+MCTEeMyNxtEU1pUTL0gYMrnxFbcErnPkQ
 EzQXfFkf9NkwugyAswvJx6jto/QT6biBQVLymGxQ4clKYAluzPQGNszIyjUpOpbx8+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789052317;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=TMgTlKMwxSdtyxXRSQDVIE3ZmIUqxfk0OKwfRuOZ+GQ=;
 b=YPEX2JRE1lCP5sWJPk0+7tVWaf/TzQ/bX2vjU7A5w6kvkpS5KEc0/WE9BBwghfqFU7fZ
 qpmpEGzcmZWacZXAW3KqiDSqObUckli/0gnwhKU4XNGYPIdoul7fc2mnkY9pkMI276SQR
 EYLfWMfJZOH1/aAtbFYadcxk22Lf8GIW5xId83aprMawVqG2ee1XcOxlhEzHkEBjULXdA
 OUBLrj1vBm1VaB0E5kjD/+Ft6axsX3fzkqqAy8iYYNOr+b5foqm/iDFBL8HZM+o8tSUQ4
 ZfYoB+ChdsV4rYh1ay/b/aJGvUAFJKyJPk4uLZSQhwLMgntOna1DWlMBkzGDxgHeUVg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=S8aHM2Cs; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=S8aHM2Cs
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8328F40AD3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:35 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so7976505e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789052314; x=1789657114;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TMgTlKMwxSdtyxXRSQDVIE3ZmIUqxfk0OKwfRuOZ+GQ=;
 b=S8aHM2Cs535pnw3ACpb6Csu9EUiSLwPb9HmrWVSAYau02qBC9Ylhdd0OquYKvRvjpp
 Bl/aPvVbA92vE6tR2yxKvUSIyaT6XtukQxHwbRr3p1ajddRx/arQYW4uQbII+SY7Fb8Z
 0OW9hVUu4Kc3NNOrjGLEJKW1ZWAifyvndFc1hNn2yp3dSPLg4VjrT4Pej7WOApAWZie4
 o8zTscjNx88hoyAZmuMBdiUkJ7PBqVpWJE+yR11zgLN2ubLJX54t1txcf4KummMkN5mG
 1lSW0Bly7C8+wzr2e5fxNejD2jhej8adp27qoEKYgavmrzjbJez5/QkyG6X6NuKbp89u
 Tq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052314; x=1789657114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TMgTlKMwxSdtyxXRSQDVIE3ZmIUqxfk0OKwfRuOZ+GQ=;
 b=WxUaiVElOoX+SS6WdcvQbaryn1a+SSurzCAmENHBF/2pcKBoRJPk8DIyEgxQIrMvTi
 42o5DAzM/c7CxGasn7WQkTvP9pbK/Tqr4qcyJ6bONAIb0D5TznHd+ChopjAJFRwmJypn
 4pRcQlneB4HJcJ2GtbyTMZrLvK08RvBMAP+wVSORxBU3E/LEjSlYyrHFDOeAJt45vzOm
 90ki8s6xpo8EKhLAmFm7Gm/dpo8km4KDtKXozIZJvOBM2sK5W6Ag2nhX0dlK6rg1+gSb
 ///sRzSM5m3x2Zte6fElMSnwZgIpK6201bpiUj3uCTedwYyrLZKrt/MNJvPnXFTliStc
 mq7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMfrRI6x/ghK4ZSQSsWl+GyM8i1LVGAS6iK2p5vRmPsf10HmwiyxmKG3/BT2oDnd7///TOiho=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lPTYSo80dvVCkmozWuNbY/mnes4mch7qWZFZq4XF/m7dIUdQtp
 aGghrGvEiyTtyFKsPiqH8fWlO9CeznuNuXFPlM4sCSBone4gO3391I1c
X-Gm-Gg: AYBFou0rm175FhdAdrE+oiVTRxcvvlCgNrvQN7smGdrhuN4yIpzUyy/V2r3P64ELp44
 kryX3vvisRw0OEt8e01LM9cV0LlbVn02f5+6U/NsnLRFd9TsWIpURlzwkP1PtdnSuRGssw7a4GR
 Yuib9HJGj+5NLI8b4BQPxA+gyC0qUWwEb5K4X7l3KAlj+Hv4BdXuoQf9tOOr/kuJ6u2ePmY6nt8
 neHUOen6O3eleIKatcD1JmGvIiGWOG9jhREeCjsynmrztvKaGqvH7nKMHMtxF1894MJcjriUw1a
 LteDgnQ/LXMgu2cmM/EaPNkUd/hXbhW6PIIC3s/OFIDVJBQ+WI1LxvJjSxmDFrV8xzMoOQqujVK
 HWXn3/uw7zoGp+P+tjhRRaQiJOqOvf/30VqiHZ1MMQA75BlJhdjyLJQGfXRZC3/0s+aF1NnS7tf
 cql5Vw9Bi0qtZWHUem8JaiuJeryo5NOZpkjQqnsBVoUONXDSyNUP5RAxdiVSkIoSSHSPlbPdCGk
 t/g
X-Received: by 2002:a05:600c:4fce:b0:49d:24fa:8fc9 with SMTP id
 5b1f17b1804b1-49d258cda59mr77211365e9.5.1789052313495; 
 Thu, 10 Sep 2026 07:58:33 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20da3354sm108322735e9.2.2026.09.10.07.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:58:33 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 3/4] doc: driver-model: state that of_to_plat() must not
 probe or claim
Date: Thu, 10 Sep 2026 16:58:32 +0200
Message-ID: <20260910145832.1276028-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFLszTg7aAQQc6EaQSEvkT4YbFpQdKSWzskQpWTAZ-M-H31iCw@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On 2026-09-10 Simon Glass wrote:
> The final sentence reads oddly - 'for a GPIO' appears twice

It does; I was trying to keep the rule generic and name the GPIO
helpers as the example in the same sentence. I will take your wording
and add the line that clocks, resets and phys follow the same 'parse
now, request later' shape even though those helpers do not exist yet.

> a few lines down (around line 789) the existing text says the opposite

I missed that paragraph when I added mine above it. It describes
exactly the pattern this series removes, so v2 deletes it in the same
patch, keeping only the first sentence (that of_to_plat() must not
probe the device itself) since it is still true.

Regards,
Mehmet
