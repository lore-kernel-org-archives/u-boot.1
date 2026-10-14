Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3613ECC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 19:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C4C980F61;
	Wed, 14 Oct 2026 19:10:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OEtSvBMv60iT; Wed, 14 Oct 2026 19:10:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E548680F3C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792005026;
	b=X6LUS74sVs2rWaDmmXkY5RzgSSbD51M+IEiokM3N1dTAPjwUqdiuwpQ9PO+lvvZejquK
	 AP1HIgIgWo+Uw/+QgY86OtULGedF2WKlMnyEf4VBWoStkLkuEai+FKRd0VTEg88odsNa9
	 6AhNRFfTAE7BdhLD3IQ9hzzGpfTlgyCHzArAYx0ZI1zO4U4/16DktEfrifhQpsVY0awjW
	 oCfcnFi+BX7V2EVUOt+//SliPoBI4+aO3HeDKMO3Et4uidgoRm17GDjGW0dNBjCo8xb+O
	 VSYlsMIKGj3WUCk+zBnszH9FL7vYVBZ/PH1VfeiIIdiL7OK9yQP5M/xcydsRG4gqhDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792005026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7EKPLoXH1xG8yUOXYVaDKDVfJckmcS1fqYQVx2IU7KU=;
	b=JxOMTTabpAfr6TXU0slhw/SaLvA2hNPmafs4glBALkr+OM5sp7ZNH+d19E1ITlNKDdlN
	 eshiUeKFU2NEjUZeTYiLUAPhtFjeNu/uuFewW5rdAjcuIu1WMa+oJnUJk2i9md+a2pjCl
	 qAkfi+P7WI5ycktyucNZm1H9cWe1w0FX6kguARH0UTGNWWkoBavGwTvYwGZz5mTr0sl9J
	 4qqLd+W36luz21CRz2BTepvOkZwPboofqsv8+hNptEtaoQtUum3zXFcEEjKoUdjuWbULg
	 +mwjEPvvAQKNumrwcCS7Au2DD6NNNQi8j6PgRbGCreRF9yywt+ptMH50c7Y6UfZ+b6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792005026;
	bh=7EKPLoXH1xG8yUOXYVaDKDVfJckmcS1fqYQVx2IU7KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=usRB6lExxFW0OS008rJOq1NNO0xiXMZfdSoKwfuA10FkpLElknoLRR5GIAZHCRYRt
	 i/DLkQ6g5wCfId3K1Cwj9wLjPODK0MZMTSdzFB/ZdKeXktWIK81+XhtCng19nCrnJC
	 fGLnjW4XzDCyLaFyzeoCuU5uZHP9Wr4vfg2hV/jgF5JXtWHlInAVOicDpa60JR98nM
	 ub9m4CKPQp2h+76U1y1to4LlsXD6iwkow6borr6zZSZeQ0eGh27ejMtYPHX+iZe3h1
	 NqWcZPRVsn9F1U8PcyT5JkUMX36hApzdFiVfCf3Ly/1cdLbyRpqpMsfuLsEzbqszuo
	 1eSkZKytQwblA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E548680F3C;
	Wed, 14 Oct 2026 19:10:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3E7AA58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A6F24018E
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:10:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OxexZ9SQUkY for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 19:10:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0BC484009D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792005024;
 b=n51VFdvlQgye/GyRiPVdEVFLJ33L0xAPgyqE40bteRn84FrPmxKsYZyzzlTI3jyCivnY
 pA27FFoMDTIbK+oPr784xOo1WRjj74oq8QTknBSJQ9HmW7PTARrdooaZmiqxbzQmnvjuo
 onUIgc+JOhCq28fnSw8gpnY41lxSkkO3pcy3CJ8TITCZoRhNtLiKukzy4k8/ZTL4FnW31
 cg0U+yKXeb2tK2pjWOQsK+9HMPBsN0rRujuGDnOQGc2HMiVw1B1APCKyWVWDsEu8oL+ei
 LAdgRBc6W5xK989Tp9b8mZQPiHr3YfXa259AIvEsWN34pRtn4c5AUdHdhRQp97J/4sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792005024;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=7EKPLoXH1xG8yUOXYVaDKDVfJckmcS1fqYQVx2IU7KU=;
 b=aqEx6GfGZp2EoHYvwt4aLfLF52xe/kcH81iuJtmp1iIKEjvtUgq8Z1WqWRaui+irVjHw
 JN0WCblxYzJnrfM7jCFqrSAi/UVF51ILl2+FE0Co2v+e0iJkswbJ91bATttm7uZJaOj53
 U+OfpnrMdn6DEw/mLVxY8kHU8VepHyhSXCatggIMWdTbdzrTrfbs7krMRxOVGaBPjuY9l
 HL4oil4V+qHnZGdkpSzvqB6uSyNGtQ7ABQ6DFRpd8qT5nEeHV84UP3yVT5s32jsrLPDzV
 s1HTbr334lmnCfgStb1q7oCe7rjvjrMlns/+3mpVCN9hzVkogo013B8roKnJTL3+vZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RDkIjCOl; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RDkIjCOl
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com
 [IPv6:2607:f8b0:4864:20::132c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0BC484009D
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 19:10:23 +0000 (UTC)
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so7497087eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792005023; x=1792609823;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7EKPLoXH1xG8yUOXYVaDKDVfJckmcS1fqYQVx2IU7KU=;
 b=RDkIjCOlqVBzepVGQk1rqgP65yB90FhvPBD+QP04u1QtkQkeOQlMxh5hhuTwHpA554
 oakYaAwTgN5BLVGE2DyCY/ovk7RnNMpibWJyha2RMGfhJQmbMTv+JG3YqDyLsWB96E9J
 nWGEUPRMS8sKGSW7EZdJHL0p/xTmxGEceK9PLJtmIaVFTxnSc4ivxlxJdxxRidZcQUki
 wAlPdWEgbl6ueoUo0DCaqa0/Xv5yaWNo1RiXzmLrghwjLTujYYZJTuIkmtgVhSxtWzmk
 d53NyzuFDV6wRCIWT8+X0dPjrBffhydXhMg9NX54g9SLviH963BgQxpuLtoV9agjIGDk
 +RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792005023; x=1792609823;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7EKPLoXH1xG8yUOXYVaDKDVfJckmcS1fqYQVx2IU7KU=;
 b=1f1olRlNsrNbicMxb/RZsmbsJeWciEAUxNcAYIq8bcvXrprmxfFd/srAdVJdRMEHWv
 d8pdsKnVcdOHR513d1u66cGOYWzNM/OBnp1//QOuKBtxZHXnVnb8AC5EbR4Dbr7RaJ0L
 qAjYjv24cIjQZiv7p65DuLN3njUrGm29nMw6zhPCoBKLB85QycvWG5x+/N8N+vdZ4PqT
 2kzhu2t+mDVBNJWmb7hNLbIS2VyRfOC45gq30N6ALgLGUIijxPsdwyuku5EYTDtTqiYB
 Kwuv2r4XptSDcx4hXEGqOWyV4naWztJL62o5LV5t5g/cDsVwEWnu+f2KEwQk5KhD8MQ8
 L6YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwo2QmRFYfqX/Sk2eJiGruFcZvPzkgBgNSpcjXUjykRSkT2bCRhG/U3F2Kiu9aB/hdXgWlWJc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ82RtmFGdQmhH43p+BVyRq8yWq9xI5SOsGvcj0yxuUbkOKLd/3
 zRQCvtgRWpM9YTtImWuYpgSJrkqzy/Uub1JwPiyLcWu0I7cOg6M/abXslH2bRDFA
X-Gm-Gg: AYBFou0Ue85w+y1IUI9ng3ZpHBhr1+leNdxmzLB9ViDndeW8L+2A21+iRw9o0Yz9OTn
 f8h5iZ3tLTsnfOXgYFIwbTVkmdVkcLu71yJ3BrcXPvxOkwYvKDUGsEK+kDg8R7MoSNA8yd7tBC3
 E7bib/MACl+mRq2tAdf33Hm94hU06frhp/7EJijpiljlpBoqWYosvPTbyUie8emwAuDQYWUH76D
 08MuCFrtuKpn2i5RlvXpMJ81rCzZT/dVDd16u1rNP3y2eIZW8nCklLU5pMQpkbx8RMy6380mW4Q
 UJwoyqUPE9DNJojNLPyIDZWS/b65+KmmsSDPS5xWGqy+BcMdoKlmoa1O0wbJDiwwd3xTMSCZkrB
 0z9TBUmmYgaxH8fiO57tcV+dTo3N9j32hjU936EHaG9Jwxcq7mqfCfs3NFnNKYd+7q7d8NCieoq
 AhikqXfJfMGZvUTfMnEy/Ol1+SGO8I70qGM1VMaCjy/+BlB+4Evm2zcMTFDvBQTl5pQ9ygC/X8P
 geOo8G7EAK0pbtvCP9DT+qlZsnqNE6RqQNNhl/7D8e+CReJ8GWGaNqBM8IyaIqn+7C8xfhE9/yV
 QXNDDkys3rxoygpr2PnsfFy5M0Og14Q2CfLouzN80hGRAXQD4UAqTQ==
X-Received: by 2002:a05:693c:88c7:10b0:359:2729:1797 with SMTP id
 5a478bee46e88-35927292f58mr16365145eec.30.1792005022588; 
 Wed, 14 Oct 2026 12:10:22 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35ca33b4065sm18823060eec.4.2026.10.14.12.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 12:10:22 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] lib/date: prevent out-of-bound read in rtc_calc_weekday()
Date: Thu, 15 Oct 2026 03:10:19 +0800
Message-ID: <20261014191019.2254126-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014-wday-v1-1-d6a45cdf7c5f@arm.com>
References: <20261014-wday-v1-1-d6a45cdf7c5f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Wed, Oct 14, 2026 at 07:47:16PM +0200, Vincent Stehlé wrote:
> Depending on its input structure's tm_mon field value, the
> rtc_calc_weekday() function may read the month_offset[] array it uses
> for its computations out of its bounds.
> Verify tm_mon on input to prevent that.

The FAT date has a 4-bit month field, so fat2rtc() can pass 0 or 13..15
here from a corrupted directory entry.

I built rtc_calc_weekday() on the host with -fsanitize=address,undefined.
Before this patch, tm_mon = 0 gives "index -1 out of bounds for type
'int [12]'"; with it, tm_mon = 0, 13 and 15 return -1, and 2026-10-15
still gives tm_wday = 4 (Thursday).

Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
