Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F2DC531CF
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 11:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBEA680FF7;
	Thu, 23 Jul 2026 11:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rsLp9go3E-YR; Thu, 23 Jul 2026 11:27:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6331580FBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784806064;
	bh=IsCCP5l3FuB48GDuOAzHGjWcqz05rh0j03jjU0WgMoU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SKmt9yHtFeghg6b8vteiGj4n7Sl6VHB4847mPjNHdIKYjE+AZwUE0PtUcy6pmCMO1
	 q2gxcGslNsFFecv1lvLr/9kkMsTe/YF862aHa2NYQJfTD5ASLntiYr78qp3gMVYAG0
	 GSIrGy70bZUa4Q/LEwU1zY2SqQoW7mTlIq8Q6onv3SCtBcuDvLIdBMh6TmYqRFB2Rv
	 GnZCvUe6G5tK3QFdXTUcA/8NTeaETMi0zYWXEflV/5y8r7zoQi4uSUBHkaiugLNwlR
	 /KPCHC3aFauN7vsh2n51pevzVzTXeVbGhxnWJnKq3410zIqZ3vVpirGz5V+dln3OS5
	 Ff9Peh6MEBLfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6331580FBC;
	Thu, 23 Jul 2026 11:27:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC63D36E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 929FE4088F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0IoaJ-SUZpQb for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 11:27:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 708DC4081F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 708DC4081F
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 708DC4081F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 11:27:41 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5aeb59d54b1so549879e87.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 04:27:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784806059; cv=none;
 d=google.com; s=arc-20260327;
 b=B0V4ETlsK6SsGdrfhExV73bhhcmDm90dv0L5ZsJhL4z59LL+sRFWlIFSB7S7ieqtTq
 AvJAhBWkZnPa+HE4kuSZksjD64kErfQJKrvwnM2Cdr65J6glb/zv01WZVoee3U5ZkyCC
 tcY+vP1sxO036/YQi35TwrelNsVqHr5Mds9LQgdAhfqy357LQUz7VTNrJxPiUSP5/RWi
 4pbHZKRWBDZusVb/2XRKUsm5dyJP1Wcjitwm5nSmnTEXIyVaLDN4VgUBGm4ZbS50UBWR
 IQ98kjzJqkSBIeCOLV6VYk3/rnCpXICybX0PZHATo8g+YFABGeJ0DndJBfU1f0+EQz0m
 8AaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IsCCP5l3FuB48GDuOAzHGjWcqz05rh0j03jjU0WgMoU=;
 fh=5lcS5Rc0ZTNSUWwpacVdOs+ZwcNFSB6nJL+CSwfxQCA=;
 b=qYgiQAwFZu5YqgsAHuiGjKRjFZvmaCHj/gZEqyuI4oS9K+5UuWEiSVwCs55VCYSoxW
 i+fmhBz+t+nD5wJ1hezaWadd4YeMQMcYp+v6HT/TdQKjUjtXvvrxzKPI4TwVanGULYsP
 N/DI2gBxYCdBlGf8XMUkZFGvUn0EMaM/mnWGIdvoWNQRFQN5X3zU3biuInq/nCwe7/De
 HdKRVPIjLOTpQTW83NwU6NLgP357cdDULPx4Pqj7k4AuacXx1wa3432Q1f6Jk6RTmhkM
 +oH7QgazVPAhC53S7BPMZGsgS7WAZNLMtAQtSDXbMn5JPORWXPih57fRKtKbKEki3Jwv
 HsLQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784806059; x=1785410859;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IsCCP5l3FuB48GDuOAzHGjWcqz05rh0j03jjU0WgMoU=;
 b=mYTLOhUlMh0qe8TZZy8hW/onVJZ9lS3+h4afiswiJiGNCmCXr+y/Owgd813aoqT0Lg
 rCSQGh5zOheIR4H+sLkCaOh/DVQcGHJ/jqfJ/yFlCEP7uRrH4AItZorLG7NvJXh0ceUc
 HaHYkolPjLRKOnSK30CrJRJQfE45EfxX0UuL4bd5ZblpKXNYQGsZmPHTzOnN6zNQkqD/
 PnHgL73honbG9S8o2GaeT2/XhUUBaNjmJ3R/ProgwkHA+Gdhj91w1HM0JQjoazRHonBB
 HK22c4NFLcjRebVr3UqpVJC4/aAwNVstoG7nF6GOlDo3ygNrcQTtk7ylLhhokTTGwACw
 qc2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxV7Mj03lSRhJLMOwqwfT98kFNe22KUl3i1cyt+wgL8q7w03e82Dca14byw+G+9jjomuaTDJk=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzOPG9ZYYdORfiHLCsNaqFppraTSHUgR9r3zbh4PU4FhuI80SK8
 eIgRn6C3bLwGLxJJ8oTv4CUQjJp8fExP3qXwWKIc+FQn/zg4hhyNAV/oW8wQweNtL2Er5ojOJp8
 zavpLUsX5tbgGOknazemkw6XVimmZ2gM=
X-Gm-Gg: AR+sD12EPggz4hjrzi8q0gkBzeGQr4etfAuUfGeJfwK6tN6AiEccSVxgBE6FkOtugDW
 gdmw9DdglqU/6rNwNw8UOFQzxcDh5uzyv5GsHC2xEJnnTgC7nCoENgggWJLWGtqfImNUg3CNPub
 VX5hqwmmP4reQo+RWa3VATWi3MxKkjakVWNvDa+QYR4wnGFFMOkwndtgRgSiMW1ihCUUCJFMJbH
 PEWEK9Q+tWKa3BYpvEl3VzVk8TNi7IIy9x6SOvu/TJuchIeACSENHe9B8n4Hcm4WHgl+jWTqGZt
 65gLPuBK6CBmhgmsC/sli/J4rM7IOnZZbJmm1jvDduArkHyq/A==
X-Received: by 2002:a05:6512:3408:b0:5b1:5a2d:55f9 with SMTP id
 2adb3069b0e04-5b2b2f66570mr589557e87.21.1784806058585; Thu, 23 Jul 2026
 04:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240930035531.27079-4-peng.fan@oss.nxp.com>
 <b80b20b3-1d30-4a2e-81c0-d974f91f48c7@kd-solutions.pl>
 <CAOMZO5D-8Ti+j3fUBAztkFY7wYZJsLcDQaFmcvH6cSgPXB23tQ@mail.gmail.com>
 <57257091-5b3e-4249-b7ba-b7d0a7699d51@kd-solutions.pl>
 <086d67e8-021a-4cca-83fe-281502142339@kd-solutions.pl>
In-Reply-To: <086d67e8-021a-4cca-83fe-281502142339@kd-solutions.pl>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 23 Jul 2026 08:27:25 -0300
X-Gm-Features: AUfX_myfC_G2juEl5XONuWRCZwbV-vXPPlTrUS6RoYVPW6ebWk_8tRL9opEmLsE
Message-ID: <CAOMZO5A9SJZ+zA7Z9oOsjm09C8Xz0pT7959UuemfFU8L4QumMA@mail.gmail.com>
Subject: Re: [PATCH 4/4] power: regulator: ADD PMIC PF9453 support
To: =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784806059; x=1785410859;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IsCCP5l3FuB48GDuOAzHGjWcqz05rh0j03jjU0WgMoU=;
 b=GqyGjVBHzDi7oYDNCAIW4ABr7m2ovvfAak0OelBPnPA2SMcYFNMPV+BGStqlsjveoH
 m1/02IMf3NLGR5PUvt7hLkzQ6kF4XMiFYtvVafWmv+zSTTDbNDsb8fp1sr34OuRZ7yKQ
 t7E91Ao57/9TCfLnhm51D7NrFaV1rTH2NR9SrJDl4qsVZPyneuClaMLwvhjTccN4iAS2
 bstP8e2I3D9r/2ZAGTY/PQ9JeTlVIverl+BOPUvw4TgtVx+YLMUtG24by5PhBTUVxJi5
 qhIYpSCR4rnoAZCxLAp3P5tT3uL3BUVEAKNtufgKYUyjnaC+OQSKvxUmNpcQd9CCDkmN
 YL2A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=GqyGjVBH
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 23, 2026 at 8:22=E2=80=AFAM Krzysztof Drobi=C5=84ski
<krzysztof@kd-solutions.pl> wrote:

> I don't have possibility to test entire patch series which covers also
> PF5300 there. I assume, I should create new patch series covering only
> rebased and fixed PF9453 support?

Yes, that would be appreciated, thanks.
