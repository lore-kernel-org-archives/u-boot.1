Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90177606A337
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FZ0dyZ+Z;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oqBzScjn
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B56C606CF;
	Wed, 18 Nov 2026 19:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1zpkZqxzohPe; Wed, 18 Nov 2026 19:08:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B377B606D4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795028928;
	b=sIcajXFrsrIZZ5e0UA+uWOK48en9FKi4RVhm2S54G1DEBhbD68LIHCJ/uxMmcwvYK2W2
	 DEHvDA8gvaJbu+AKF8TVZBrjKe8C/BbdIg1PxAM2FtSiGxxzHZPVmTDDWYx4fYV+gT0D0
	 gMhxLx+oP7rfKkwhho8KYJretzTrA/MoPV/cXnA5SYMbn4cG8xVRkw7rQeN8wDxXGJT3t
	 azT6ibb7yQd8tWMfatJW53IprTL3CqThLjMjJMWp8FoqAir8hawAUEJMC1AFZ/HCP1xLL
	 WoiH4B9GX/gjofibh5OpOW4vMNaH7IIJ8/wiYlFOjmaJ2OBFqeppY6eysYIQxicCQmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795028928;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+ZhieZk3hpiyKq1ook7GySHvBPIjFgWP/89rblLEnig=;
	b=Qrj7UYgD8f7ho3wEBnk6Tx068exzKg2XRuvmrD1BYOEqnukyuRJUGXgyMUXPrT4J+uxl
	 6G1FbBGYxmQ8omoGoNIU/82Kmvceda3nlO5wzE0yzlMssXKQ0RUEHjSg/zk1Z00F1nh45
	 6/pc9RUKp5l/pjY3M46OlvdtYES57dK2sdmK5AhpcBU0is66arFRVT0q4LJ+O98nD2pRJ
	 ngC4VPxyEPjCJvsLFfBHkoA5MeWYa/n3KSDSbG1AikDYEUDCohvUdBTFygoLktfe7qKP7
	 6x0pmoPqE/wyWsuabA9wBO/HKWS2DPmyOSMjPPmjzonP/9Scu2YJIHS/jpRnWq/4Syg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=oqBzScjn;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795028928;
	bh=+ZhieZk3hpiyKq1ook7GySHvBPIjFgWP/89rblLEnig=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FZ0dyZ+Z1vgZ3ssKtf/JTq6krmQuAT0kmiQLdz0W6ZDepDsMFuthqgAEVlXsMQsqc
	 Daxh8OyGXlgnAJa9EGSyOSnz53zGo9Lt3YBheNXqGTwZNqr6W20HTf7jvAfWzDj0mo
	 R2c3yJ2GWfrqqxb6TcGp64Zwi7+FLSjIEuxPCypPtRUG/JolwKcrrXTKFMM67ySQkg
	 zo1R/+DJRxxChEAHqaBR0sMsZfKHfCVvu/y+0425dcN46HGRifEhUBVGNy9tWxBLlX
	 Ie1JYu6lZR3wzerB3i+T2hl17w945vRC9hc/LHNA5jYewbeoEXJcvj3Ks1j3S+t7GM
	 82xW2pxGhhqjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B377B606D4;
	Wed, 18 Nov 2026 19:08:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EB189F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 04AA360660
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rngDDywCC0G2 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 19:08:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D1922606BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=oqBzScjn
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1922606BA
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:08:41 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-8490a7d6696so779069a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795028920; x=1795633720;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ZhieZk3hpiyKq1ook7GySHvBPIjFgWP/89rblLEnig=;
 b=oqBzScjnDbMFzvI/Mkg3XpwJM2tfpZ97Jynb2ORqGpHRzm7wLCMmxveuRPo4e64AtB
 84sxfE0Hpz6bUCzxoD0EvzPri/B5kYvJgMgru2gBa5AL7zh14rKb9vQ/KHAYB7Qr/1mB
 uhlGWBZMsfoDGoGRgghnsXaEQqw/4uFvm2AqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795028920; x=1795633720;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+ZhieZk3hpiyKq1ook7GySHvBPIjFgWP/89rblLEnig=;
 b=0k2eHeg89CDd5ciadrRHaXqMtLPS49PPxQqTqjSIk1D28+II1Zlxo05oGZUQL3RzVL
 TfaCkvfXQFq5aIV6ZhtxLrBHd+tmYqiB1fRD9DeUF+v1XfGFf0oeLM1YtyKXnv3Iu0PC
 aHwsEcXiDGnfCY1gfmfL3JYOA3n2WlVnUwVLoOcYOD82RiXQNY/nJeApeJo6pE7uIdQN
 5iSIwUPnC2G6E2uphNU1dAfOEapSp+x8EoF8G8/h5tFAf1lzdebxnpULeOiinKku+eEH
 WrIWut4zQtJHKUvWlZyZph87TJwC8ohhcs5/JAS28lWUc8mGRfM9WuWGJ//YeaRXGO2A
 I8Kg==
X-Gm-Message-State: APuU4Z8k332cdt+Y9aCaRjeJ0j6lqmn+8KdoEmaV3EBV2IDd6/cWnFvq
 kFiq+UkcTWBsNWf9mqubwOqX4HPN3vK67z507f3CbMKh8JVRTyd2eDR8rWHR82/l7aQ=
X-Gm-Gg: AYBFou1QWeWVEqljmRDCqOZZq2V12IwdJvmZ3wd/AFtZaaHKyl7cQlJl8GbnLcvmu4T
 npWQshw/tZUwdg8uu9z3942X+mUZ0P+rYmKg1n0wyt8r3QZhIZeYIjWWJibhr3EaCYmIhwHjlJE
 UGOUl7Yc94jXYdA9EkGx02gUPiK1qwHo+I3ZBD0qR+q+9KP+wwxISPhhuPirokbMzjW66OZlqbr
 Xv3+DMIpkrB0Xv2it/rCzF+K0YYPEmNHSd+FEc2JO3gfGxY8xKNPWA7omHWResaDg1klHZjI5y/
 JlQG3e3KGDoJVo8VojX7cdgZb2EaqjnEj/YtWrxSWoa0da92zyJD6q5gyow5zKpNQkMpwzQFQ4y
 mBh7MZama63/0FB2lzSk4QCutVxcM9jBZigA4lnGfrfls/XvXvtqCZtdD8Bdr/GbO+zaPJtBNN+
 H4UUKMKIu5wyaJiq68a/PJ2VTTxuyAeMOlV9YYxWHFYC+XJ6Rq2HRWBWbCGnxcXujwZJww/NQQL
 3Xx51rQnO4z/iHzU4eAOfyaiMlojGpU9iSbE+HIh/GdCthlMszEtzgikZ1QK51PRpGO6cGn6otC
 n7DcRonvAf5zT9K9NAt47oUHXdave4LwajsNZboDHGbBIgyJVUAYGnTZ9C9Zr7lrkPL+9IYvb3s
 TejsJkm5Wo5FwxEHvUEzgYeW+M/aMl0UAaCfP0NhYvZ4anGt/cTJWZmK2AZxZtyhYH6P9O+0SFl
 2rACnnVk75SvLsQgPeGjHHmw7U3kqsgvRjQoX4+mgxgQTP9TZ05EA=
X-Received: by 2002:a05:6808:2384:b0:4c4:8ace:cce8 with SMTP id
 5614622812f47-5773a8ecb69mr4113066b6e.8.1795028920389; 
 Wed, 18 Nov 2026 11:08:40 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5777b39306asm2052999b6e.15.2026.11.18.11.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 11:08:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20261110144956.4094684-1-trini@konsulko.com>
References: <20261110144956.4094684-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py, buildman: Update filelock package version
Message-Id: <179502891946.3148473.4423352058653127213.b4-ty@b4>
Date: Wed, 18 Nov 2026 13:08:39 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 08:49:56 -0600, Tom Rini wrote:

> The GitHub dependabot tool has reported a "moderate" priority bug,
> CVE-2026-112909, with this package. Update to the latest version as the
> minimal version for fixing this issue security issue has a regression
> with our testsuite, which upstream has since fixed.

Applied to u-boot/main, thanks!

[1/1] test/py, buildman: Update filelock package version
      commit: 98e9beced7b81b29d07dd5c98d5e9362428f13fe
-- 
Tom


