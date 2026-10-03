Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783F9CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 14:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE652606C5;
	Sat,  3 Oct 2026 14:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCuwENEYdu-Y; Sat,  3 Oct 2026 14:30:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1DD246068D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791037858;
	b=HrfWpB6HcUaYRbNa0TG4SDEtlD7KBUMyTYw2SZQC/uihgmJcqyNaPHzJF5jqzaTdm2Vd
	 Za+/kBNkBEAB05Vkt0x9u2xO6f1seFE6prjLPOiJBcD0Zdlky78PouIO5mz2xkJQ0wQRH
	 KTDWfnGY/x7vpsCSCilysH0v9pXrJ6NNF4Ok9nOh4BukNQJVg8XEz+/JiCDRZoFBIUg6i
	 z2Mkf16E5bCVhfbreBQxBro0W+DCcLAbITk9ODMgStBPA8u7KmHllKNK2hMFR/YusXj38
	 np7zgH8rbc35NOhg06AKU8VANKaDTb7Yq0Q3K/T7rwD4yu5V8EB1cLB2GO1hBTGvNYw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791037858;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jxeshH1mXQJwdc/JNPBaN/ie2cJt3rtV826jVbiWYso=;
	b=HODrSFQg7AMfOIoOiw63M/8HHNRbc8lcRg9YujFuCyojjv3GtO8++Rd4+PV5KYb4EAVw
	 aqOeqfOnY/lRODpg6bA27aMQd7JWocwBr5wMDkGNm1K4JF4tMY4gqfZgMGOAveqsh5mij
	 fwqTpKpgpivJSFrzZWAXWMQ06gsq1aT/j4IHTPrnGWX5X/VttbLOOiop8l4YzmrpSSRXh
	 PvxE5wqH8sLZXWEsATULHZDtY/xXJKL2LJN9vl2Bl8rIRioTJdQ+ZMPu//6PJCPTzmN3N
	 u5+yqPWqxNi6abB9oCJPvHMmAFQB3R6YTIYDlpim1dJaSzpTobv9Hs5ZrPsJz6s6Tpw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791037858;
	bh=jxeshH1mXQJwdc/JNPBaN/ie2cJt3rtV826jVbiWYso=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bpfm4/MLjFVNPUBeTNqNqgBYaCmc+tLTsCb5y7W3zSmAvDlJLcutKyYPWfo/CZ70A
	 R6Zmv53chuC3RzszZQVs86eS3h1Nk/pEGP0TeKLEhIxGOFxu4ihS+Ia09AeR/atlDm
	 RPtvhmVmvFWGxGOu2oLTXY4IJJi33Ix7QtdBN5AEwZmK+ANKbGHN1sdweELOPjky5H
	 unwcBkzgWXYQGURKblooKJPhYX3zaVhaDKr6tyfZWiOEsnEJqewHpoY8T4mQss3jgl
	 0Ey1f9mX31juu3Ys2Jet4FS3dQm4gRBlNhuMxyYr2O9L9Te8jjVcG5ubhZJatmEKSh
	 mBPiV/Jc+aclg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DD246068D;
	Sat,  3 Oct 2026 14:30:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEB3F1A6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A04C1400AD
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NwnAIQqUMxKt for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 14:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9C32040024
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791037856;
 b=NndtLOl3Vv+FXuqJL0G7CxM2KL4QixPeIaXfPoUkMpeI9Oigl5PyNcG08fPY6Py0Hhkf
 DsT8j2n/t4jY89nQP6CNfjA7NJyAo3zfl1ihQBs1QT/jYy43pNMLg7u2JCRZ/rVjjizLG
 bFUZhvvGu7Y6fJlIea7HWQF24atVMFToHpioPbJozWesZFNGEj/S74DnSCPgW7FVEcoQ1
 sJnz/DukuY76bklDEdu/SB04B/KLPLFBqxHgpT7VxmfRdA5greSys88aFcyuSYErHmx/a
 n0HTEmp5hsnHxPaW4um4Imj28qhCuS9Tz3mFNXPGDDx42wKLA9O+ZlTTHghFQjwfWkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791037856;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=jxeshH1mXQJwdc/JNPBaN/ie2cJt3rtV826jVbiWYso=;
 b=hOFL3OOGl3SVwlHEVNU6iugAO3zyhgySuWIxhkhOsoeDWClWniXqd2iy9U31ubJuP0Pd
 NjDp/VE1hEjoQqjjM6OqigBE5e5Nhm1llJ92xtsBi/ut7YXKd27wosHswW019JEpbaaqS
 5OCFg2i/mV8CstCi/RRqtlRkS3qPschx6ft1JEvvPnbsB0rHqFOqduuoYQvkQ0ggf6cSU
 +QyGQjm6kgaFHrhPJDPHkGW4wPw+VastuAS64t1ZH4c5hdwPE0kK3aq2KSAW04lp2hBiw
 88qxZl7U34fOr7GeRvAlkem+EtQ2KUOpCHqCVrs4r4RHub80KkLf4ERC2L7Fw5HpnZA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RM+jNeUA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RM+jNeUA
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C32040024
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 14:30:55 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6aa850436d3so451648a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 07:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791037853; cv=none;
 d=google.com; s=arc-20260327;
 b=afO/LseRHyjI7TGQ+4sd9a2S1XJOAj88Owu5Er8mmPUwGB7Ld1qrN3KFEMNUieB1Cv
 PoNk01Y0Y72IoB1b0qT9JanLZFG1DVj3O7o0JPOqXpEIZYf/9FjoEQzDMxj6q7l56xmo
 epNKlxQFihAO3BmQLA/ecd3WEw684y0pnEMMwlY1ih1SDHSzpKMmWWoE0g/R7swgxppB
 RBU9fdZvJazMIghnBRdLoXugYc8aCW2cdGB+VeF733kZGQhKmOpojVjKe2gonNqxxQwU
 SWVnTTAAOgvit/97bMa//B8wqcv/3ozqsi/sTyEMg1ri0sF1oYBJEMWf6AuBXu/hMfVt
 15aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jxeshH1mXQJwdc/JNPBaN/ie2cJt3rtV826jVbiWYso=;
 fh=8i3QXvZ6MkPBZ6C8QdOFuFXMaD16QkYnfny0yrwv/rY=;
 b=GYfgKStMQaNGn5wDOCTYfCeN5uneViVtUXYdClKiLjM79ePhaqFxYHF5FZFwNb0uqy
 1S7eVf9NJqiXDk6nA/2IkS/ylMZfGPxE/jtUiby+yqIaILXZSQjKBbTs+PwLAQyelulE
 cmpTxw1ZIjerqYWqqVPBMZuLnjDRaBl16svD9PWs1+iSji9Oh0l4R0fz8mHFo+5QmXwp
 tMt6FysrmPoXpejw3vqjNGkCCo3xNi/yA2qBWVGHe+iDvO/5xoqf17TNwpIH796VMWAe
 G6nysuBFo6PedaThI2UtHIAHxzUu+FtgBX+6F2KZqWA7qroJs4ZzT3D2TXLSKpYlRyXI
 JGHw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791037853; x=1791642653;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jxeshH1mXQJwdc/JNPBaN/ie2cJt3rtV826jVbiWYso=;
 b=RM+jNeUAk2Y80Uda1sLVXm8kJdo0oOA8KJGR5MjFrviicJTlJP5+gpIdJum6PdG5Mo
 OoHj2WsWIrP6SZu8NxnQjz0OZoKq/9zVEanm6JuKfKJ42k9GxdugTXSU8RfVeoGaJJfi
 JGH/coKAdUGfG0MJlb5SSkiEiQp4vdsYS1XfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791037853; x=1791642653;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jxeshH1mXQJwdc/JNPBaN/ie2cJt3rtV826jVbiWYso=;
 b=V6ZIoJzZSYg2zNi1aGnfEHyVNguU0g5S36xAWTDQswYtvtmSvtDmgjUDsQmTQtPusl
 eHYbUv7EjbCgZtB/VTsEGqYIlQDRPXxnRlyHUnHvMhtPZAYOFkSG0jfXyqeaJYO2unJg
 XliAApmoZNo7VGB/DmmXRdvD8MAs8EKoB4KCxQ3D/lO5+X1ZUjfRwB5Rx6VMfTdWUSg2
 s17oaCR3P+nzzDdJ+8eL21FSmlm/qhoDCsv1GVy41X5PhqKvmBI+iEB3jEc+QLAJFEEh
 acyYcbmPvvsEDpmTirB9NqcvQf4THJBa9NC9O02tXwPIC7teF+c3lWGvOySw0dd1G/Ot
 KQRQ==
X-Gm-Message-State: AFq9FYKHeeAn9KkHbwwBV2wkL6h+AlXwjqDrZ/YhPoiDRJ9Je2Zcb4du
 nW1LLuXFxXpgFxZggs9RNZh6fC5X4EIXgGz4keRXXkmnC/tD1BOoReRJ6sEZfQtGHJOh7uTXXQJ
 pH0PersP2Lhw0l/TR3MolGh5eWZe6khKDMwSvW3pvCbp/2PQIhyyGvOja
X-Gm-Gg: AYBFou0xiYLzFcnM8Tw9X0BsjK0eBNdkCIr5DUVyFEgA7Ypg4FrB5SAcOvzU+sXYh5M
 +oUroz0oRg1JtcMjx3UyaBKaFaw+a60l0dflGQTgQDU3RCMJjbjH8rh/pITaKYBRxaAABAOoAVO
 pU8m+5gijN/2G/7vBwnsowN2AROSUZDimevQo1vyUtGJYYWB/kaIgKMxX0Ted3VlyBB+5iKZazv
 LO4DH6fNMdqQvVuzf8Uh+0qjxCrBvFAIYFw7qbbdSqm8rZdfufq4UHJ7CrYUxsCcP2jnDG05kh6
 PagVSbN85mXrrm/D/MJaQ6gv0jpSnkazv82XND1dlo5Mu0k0XhkK8p8=
X-Received: by 2002:a05:6402:2709:b0:6af:a64f:bd44 with SMTP id
 4fb4d7f45d1cf-6afada35853mr2325472a12.45.1791037852877; Sat, 03 Oct 2026
 07:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKnvs4fEmyqAbNFobx1UR_KXhvrA_MqttNEpktrjNAH3vjv7w@mail.gmail.com>
In-Reply-To: <CAFKnvs4fEmyqAbNFobx1UR_KXhvrA_MqttNEpktrjNAH3vjv7w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 15:30:39 +0100
X-Gm-Features: AclHuK8T_m2add27qixuJittDeOQYmEunQokVmB1kv2sag2G9ErPvO8VBi4_qlw
Message-ID: <CAFLszTgHB4tZz7=eEk0QvOxVwUvSwC7zy1QqtUMtMtEmKXcJsg@mail.gmail.com>
Subject: Re: Can u-boot UEFI provider implementation boot systemd-boot /
 systemd-stub?
To: Umut Tezduyar Lindskog <umut@tezduyar.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Umut,

On Thu, 10 Sept 2026 at 13:14, Umut Tezduyar Lindskog <umut@tezduyar.com> wrote:
>
> Hello,
>
> My understanding is that u-boot has its own limited UEFI provider implementation unlike some other boot loaders bundling open source UEFI payloads.
>
> Has anyone tried to use u-boot's UEFI provider implementation on arm64 with EFI applications systemd-boot and systemd-stub?
>
> Using AI, I mapped all the API calls done by these programs to UEFI service / protocol. Most of the text input output functionality and graphics functionality is irrelevant for my purposes.
>
> ASCII text mapping table below:

I think you are referring to UKI (which includes the stub)? I have not
tried it, but there is a good chance that it works. I did send some
patches for an EFI log which keeps track of the calls which are made.

Regards,
Simon
