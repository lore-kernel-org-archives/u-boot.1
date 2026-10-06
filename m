Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1ADCA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 13:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E9A180C55;
	Tue,  6 Oct 2026 13:00:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8fl3lG_6Pp-X; Tue,  6 Oct 2026 13:00:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 185C580CD8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791291623;
	b=ABGnsvR/xZPjyY9xFL6chvorQZLv5szzP3rdyKcP8MQQHd8eOKoK7oGmYexxTb1wmXK4
	 oDHVWNHKYkSuRV1D+CiFtzqZkIPXazhavO5WuBDfHGwPH1nPTxL1Sw3g0NqQHv58N6GT9
	 5rmXUbbRqGebrsXsFqWGUFII0xzOYGVX0VJv/lk0cgR0uqFC7XDnUGcKb6f08ifjKiZNf
	 YsyWYEZk618enk0q0gPatbovJBIGyR7GTBKhq1pZ3JS78b1np7KatzhprQotVrlvINHs6
	 xwZXSxiqS2hXzgn9E1+PsIHizpfsKHTL1o1C/76UbTKrvB1hri2rX41uP6NYTGsKQ8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791291623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=li/BzBUnAPXqYhzRU/DePshymIzaEhrBMsigSe9edy4=;
	b=ZlcW3P7Itxvm6Qa4R8FF77aRLN6EOxg5VUh9sFIRz2w4PD344wVpfK6XdCfNuXie/dqr
	 MTkeTaOaTPQx/kfkjEiHkNoUte/7efvc/RfysXbqeO3g0BYzrZ799J5B6CpCRwC+E79gg
	 SYaQuF/I6nkjWeWlydsYTPD0uXg8q2OIQ24jhbJNsZNQdreDO6XagPz2JQkH0BtId9wcV
	 3pFmTGYPwzJHznhqJl90XzHei4yb0G/W5fNBDMwiKXhn0/fsmQ9kpnotnqLUx5IIBiKO8
	 uGVkNQRRB7XhU5M8YtSKTh0PrjcDUc0KFyendFOIFAeXS353cmAP1QNogJwpbwDOeFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791291623;
	bh=li/BzBUnAPXqYhzRU/DePshymIzaEhrBMsigSe9edy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YgX66k/ZqxIGJrSC+FtQYdH0t0eS8Uq6XJpgP2W3R7uvtB0hPy32IJ5lmyLSzHc17
	 i3dF/rwN7BiYN8N90BLrWOh9cQuSsFhqsbAwwBz152x5YACvItYwi6sHMrcWOJb6QM
	 yTCbLyOohNzdmHqoMTYE637X8W6PtqZrfW1pGMDQSPAb3tJYgrKvBJucTPUSCm+AXR
	 CxpPY+zNMFB063062EoRU6yihjEjf47HlANg3D+mj+ALoDEzsRFhiXSAUlb9PVyN+7
	 tJksEDS4Q/2zoRzH9RyT9ySivuGS/4AuJoQqjiCQutuELQM8Z6uRj3Otm31IZguTSO
	 JZdeERpKswbiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 185C580CD8;
	Tue,  6 Oct 2026 13:00:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A84AE32F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 08:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D6F44055E
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 08:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwYR1H2dy9h1 for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 08:18:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C5EC540557
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791274726;
 b=f5/oDvtonoX0iHcdUzy+yFQnj5cO8/tSosODo1jzGlQ7h26UUxMzwH0mgppgiH5nI1Oy
 77Z6nu+NCL5ktugd9/pumcV09L5jXPL1Hil6X62EpHiM6fxTMCRQNxcx+88kYC0t1RN5g
 a1Ir2IT5DA07ivbZtOI6XYnBMr2O3VrY9Kp+tnm9ZURIcVhaG/n1+62BlhaKbSN2ky3QJ
 kNBIZ/zoeRShBEXKEXUDeVfenedSY19pmq4K3jGmKwKi6lZIh6f5hH4/otYNq9SM9CNYo
 LScidtJJ7DjvVUxX/808oavKDdoa55T9PfyYpTECQQAEyNi6hSKbRv67fHw3xvVmg3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791274726;
 h=Received-SPF:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=li/BzBUnAPXqYhzRU/DePshymIzaEhrBMsigSe9edy4=;
 b=tIahzyl14mMIq4xEGTx56IOblKhMYdnkHojAGIRUQn8CmuYDvYymRH+AiqhEghN0fJai
 klbkyzXq7Ngylh4U5OI+vm5FNj4FquKmcIj3e3V0LwNG+O/71QfkaPi1uZ4WxgrWitcUz
 8JrXLXXsI9lS6/UQZKSMUXKtZi5Ms2wg5aqsULaj2tLWEq296DGC8uOhcwxxJQpFoLqT4
 OsutfbaTMuJMwzEsZo6EmPrlhbcTnPMtmD7i4A4zbtnlJUFSZuLMAWxrq+6OR5hn8N28r
 xTd1OiFf2u1qT2uJ5Zv0p8HcW1Rt6qvyxnDS7toTAmKzkqqLzIqoFdA0YzGepgIxDdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=OVb9XDfx; 
 arc=none smtp.remote-ip=220.197.31.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=18102059357@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=OVb9XDfx
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C5EC540557
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:Content-Type:
 MIME-Version; bh=li/BzBUnAPXqYhzRU/DePshymIzaEhrBMsigSe9edy4=;
 b=OVb9XDfxbw9BwXeGrQLuzme9STdVQi7yrna1peBKFO6QXo8MXbI/yTVj9aGk9l
 LUE/wjjfmLXujSkIFWv304iHktFXzdIYSt7G7Em7l6qHVqNX32uC1oixVYKk4e+W
 rO9m44RDn1C0UWPqrIiRATz3DZAH3R2pIZcsfmidjO48c=
From: Xiaoyi Suo <18102059357@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 5/5] lib: sm3: use memzero_explicit() for the message
 schedule
Date: Tue, 06 Oct 2026 16:18:31 +0800
Message-ID: <179127471103.744.12789818892668439293@163.com>
In-Reply-To: <20261004152715.1574-6-18102059357@163.com>
References: <20261004152715.1574-1-18102059357@163.com>
 <20261004152715.1574-6-18102059357@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CM-TRANSID: PCgvCgD3fyzXrsRqb7iBCg--.60163S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1rurWkKw1xZr4fGrW8Crg_yoWDKrb_uF
 95t3Z7Ca17Wrn3ZF43JFWDtrn8WFW7WFyUG3y8ZrnFkr9xuF13ZrWvk3WfAwnrZa1fXFZx
 CF4Igryag34FvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbRBT5UUUUU==
X-CM-SenderInfo: jpryiiysqvmjivx6il2tof0z/xtbC7ResR2rErtdLhwAA3K
X-Mailman-Approved-At: Tue, 06 Oct 2026 13:00:03 +0000
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

Tom,

> Why is this last memset call clear here safe? I'm not saying it's not, I
> just want to be clear.

sctx is the caller's object, not ours - it comes in as a pointer argument, so
the write is a visible side effect and the compiler has no way to show it is
dead. W is a local array that nothing reads after the clear, which is why
those two do get dropped.

I went and looked at the dse dump to be sure (GCC 13.3,
-fdump-tree-dse-details). At -O1, -O2 and -Os it reports only the two:

  sm3_update: Deleted dead call: memset (&W, 0, 64);
  sm3_final:  Deleted dead call: memset (&W, 0, 64);

and nothing on sctx. With W as memzero_explicit() the same dump has no deleted
memset left at all.

One thing I ran into while checking: there is also a "Trimming statement" line
in that dump, but it is sm3_init(), not sm3_final(). That memset() is an
initialisation anyway - the pass drops its first 32 bytes because the IV is
written over state[] right after.

If you would rather see the helper on the sctx clear too, happy to send it th=
at
way. I left it alone because nothing removes it today.

Thanks,
Xiaoyi

