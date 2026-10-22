Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C8606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yEBNvz5C;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZPLSVU1z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68EDE40A3B;
	Fri, 23 Oct 2026 00:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SDxl33Tjsk3A; Fri, 23 Oct 2026 00:13:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8DDF740A30
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714395;
	b=cjR+h1WafHRprnzbbCndguREesaNy7JPRSYjQqriotwzhbQKJUhoXUHCWNZsHcukTret
	 XoPoRYp4fi8STLgqqyUsHSlI7DsrTBCFrw4G3Vk+TXsxV+vca3O4FxPi9e9wHa/HXVTLI
	 V7zy4lcLuI1Nn+P+XBFBwwxD/sK6M1vCvcMQuvfsHLsuXhOSk8RfVZskGILydkvEIBkBf
	 4sHzJQny0pslEcS3a2+99jGFkQMoyBChKJOHgpYD6AaBs8Szk7Hz/K/0CdzWIMQ097RRA
	 bhSp0lEwLCp/BGQ4qfr1kkgDC1Vp7kbUmv41d3KgCf+SPtGrlOIvaG1QxaDoxaguKPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714395;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p2ZQRrvjuvqE1itBzKjPcotlpIQX7l1P/2fQDToXU/U=;
	b=j+gvxBQ+dm4HthLeEb2s4+Pw9KohX/zuhl2C0coR4XyAiFocmSsqUzFED6ukZMfKWvYO
	 ZsPHcCDyUNwyO985XHDBmvkOMQfqGuuHLjVpHqVXFn9T0vHWuGVuKT4AiXpxD9XdK/5DB
	 I4TGKV2i+MZPEnnBM0ghyQrerGGB7w3k7SSXSnxULLl1PUjjDueciw3DLuFE0ssi2MtPh
	 6/9DvUZPhtirBVam9RR3x82HZX3vAXtjy1wxcXyPdarifych5OTji+SJz1MkQjMIt12pv
	 49HDIbsgIpQLK0kCoxJwZ8MWR5wlkvde9PUNk7QwfycHb4Tv4NpiVV3nhZrhMCFtQMA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714395;
	bh=p2ZQRrvjuvqE1itBzKjPcotlpIQX7l1P/2fQDToXU/U=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yEBNvz5CxgzptqfYy660OP2iEeLtEu12C3DYCT/iS1xPI57+IYk41OGrK1Jny3jfG
	 2uwry2U4irwiwIivnZeR+Lk9HZH1P/MWbD2OdnF53AOb7XKeSNivxUGjmsQiCgZsMU
	 DlM8fyuyFFcoUstbfb7ISMbJrd/hFZ0V0eESCsoLYJsqNRR/OkFmJZ5qO9Emf9Lp1H
	 GrMlbsuTeNOyAs5vB5LzoTEov+MalWtJ/F7Zfd0E1Yhz0trEOgMVK6bB10lteo5eLQ
	 67q/u1YJBI/EzE3Q3TsyWxE8ZVwMz6btsUTOuatmRQvItUqMH3rXvEz3miOwmXipW3
	 GQk+JaDEPZzng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8DDF740A30;
	Fri, 23 Oct 2026 00:13:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 794D349D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B45380A95
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nCfXVNV6ucog for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:53:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B684480C1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::32f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792713225;
 b=dlAL5I954ktC+nT7SQsyq6HrdzX/NAC01HF1gu/z1WvdlcJDSTvf7zG3DKcsT7ngCDMo
 NT1MtKNkRgBoIidBcB3ICPVYZH4d3zhR/pO4WUQDIrWVLgDYx9G+5EH0LLCvDndnkyAO/
 QBYHrQgME0CGlaXkA6JyG6bU3nb8SA73e44nDZq5na2x8GB0XcZJp7epmo5cMWfpnsAt0
 oEFn7MFw/kFU4G6bL0nZ7nyW0SojokQImwsORUl+44Zedbqy1JatcZfP+b88mkt5ZXr7z
 /QMnwuD9O0XKMrL5w3F7fObmj+RXNdKNZ07gm4q+NvurLZc4QLQcSvsDXdI9sTPvZOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792713225;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=p2ZQRrvjuvqE1itBzKjPcotlpIQX7l1P/2fQDToXU/U=;
 b=T4MeXkUXLvz01bhuyVE1B5pjimAghTSHhTxI4WsAaS78BrXwmfgb+I41a5ytjGZIy2dk
 UVOF5sZZMs2+mi4CIK9+VkKoEJcinIPAKgSKmOddkrP45ILkpg+mtPae1Nuzt3Mv0fR2J
 ECqi/iOuvlcFwFF8kBizR3ISOZXT4L5HEOM46Nw0UpHxqB0vml+EuBHFeAvtM/H+cHebb
 9qtBoKqqO8kKU/sSaxKrGjCT3p5K+t5uMRXS91rg28j8fPPDtcUjL2bZL8zZdD8R6747I
 n5UEqxmjPG3IINDHH/q9Whvcwx0LOkwYqCVWw/Tk6nZDLep4J5/RsyaXKx2K8oTx5Tg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZPLSVU1z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZPLSVU1z
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B684480C1A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:45 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-8253bc5a613so191394a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792713224; cv=none;
 d=google.com; s=arc-20260327;
 b=HrsA+H/s+YT49kDsTNSEnaIEoFwqvQ6EQ/Io6oCud7kwgBB673M1i2/F+N/r9lXBoA
 Y+oxiA8fufulxnGYQBm2YCU7+s0mDno8fbfLjvFE6yKoiy4br3lHG8/vsG1rC+hhDL7a
 CzkeK6+CisCKc6RVEeurxBVpDCyIjjhL2lMoSaNxRXT48Grzo/QpNjHiTIJaoU43Iv6i
 eBNOEH4Jy0zkG3nnbozexyjfgAy/gA6q5lkscxNsC9KXn6epDuPH3frokVq+GUSwNT9d
 yiNHtcqUvNmtRw1Con/doR3lg7iROVjvHwJU6U/tS/FXTB3jB7AZtO3eUPjI3CSvXNwC
 sYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=p2ZQRrvjuvqE1itBzKjPcotlpIQX7l1P/2fQDToXU/U=;
 fh=u4xG2KwCOaAX3LACWiWdBW7foS+n2V4JX1MkoNaREaI=;
 b=UM5qCLA/slgWuhUQBrVEEoI83dTIsTqqPb3ozWbVmNQ24VDGayFEkkQZkZiG3+tsHf
 WBpUOdFW2k15ksGaUE0iPvGSDFxO3QxrxYDmWPks/NwzK6D+Mpj+RLGDWorb8OYW8Sfn
 3v3hIG6zkosI2qkDOEYkORi1H6sXTenl/S/gxAH+gyGJGPqHtciasRKwtldR+cOTZkWM
 zSs/YUnlZJJ3Js3sywz8vd2rR8c1N1dNmdhKIiBscXJTorivvp/7yZyumjUBWJO3JrDh
 AmO1+dNf+ivhuDt1i5xlPUd+RUzPZBpxDrK5XulS9n3UYO7SArljOLWv9Co6qHJ/AKMn
 NNNQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792713224; x=1793318024;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p2ZQRrvjuvqE1itBzKjPcotlpIQX7l1P/2fQDToXU/U=;
 b=ZPLSVU1zk2a+bKK56/OpVUUVfwtFnD1d3xqgITGa6GwgtdYDpk6Va4QLBkzsj5HdYd
 qFcGZ/YTKtYr/JgT7lFMpYZjr28sNn5OB7HWkJ8WeqisDTjUcssXqiRrjAm4NXfV9eVZ
 Xf1lNEEcN59T5ap/RfCxWUOqLtDA/+Rmrqud8961zeSaoh0F7Z2xnrWzA0S8hDlA9oZq
 K02Tw6qHkjwU3SEcSj7p6bRZfHoGeMI+tBnfVK0rr3nW+0ef7yDJlmJkRxRHgPxW7ESv
 rzy2iizwflccJmlziP3JmX1wtpD3369XFuEv31RNgGVJTd/H+qtEO87GEpQzTkiu3S7l
 x4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713224; x=1793318024;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p2ZQRrvjuvqE1itBzKjPcotlpIQX7l1P/2fQDToXU/U=;
 b=1hLjuuN7OIr+t/GzQkDeKzYIXAKzvPzpUmGfbyz8Wfw4v7f/5G8emH34LelZGEn1IA
 3NbVKfJ/tiBw706Ovp9pvsJtPD09LdYBKSCY8IQljWxBni3Qc3SfMfog/BmYx87znSEM
 a+pzlpec7f0gcOLl3UFX7RhRVoBK9o2lEE9ztJiFwALbDl7H50ag6X9XcQiTwb2yT3pj
 VD1fsmbGfdS/n5U21CS0Rgl2UcfCUzJFe2TBZuS4qO4xXSXzADeZkH8EswX25wrZdcTC
 aZnNrVpciT91VbSSCB2u9dqh06MrvWvyuQSzs2vGi/GhjoBJM+4saoP/GIfBba5sekEt
 HdxQ==
X-Gm-Message-State: AFq9FYJJJaCBDZVghbRwBeJbuhJoUNXkrmINW+uLgITpRzQ4yLvei+S7
 dATKX4Vxeupqafcpi64k9ErcDPC3kSJWbW4jz+hJKp033Q8y+D3YL1HS8CHnTCjC6V41yuxmpEw
 KRxhwM42yyDgDJRjOyiVZrQYSvb8T97iPKWEM
X-Gm-Gg: AYBFou31Fpks+dFbXcypTGSAxPRS7GpiOjIKz3hUpEnhnNoZ6/sladfNDnOXSfERI7q
 wsZ7a6xWn6yfaco92+OdvF6JDt1Q9+1abdYNYPrsg/Xt9H0JbVJOgi6dlRK+11kdVBbZZh+I9Mo
 tBfX1Lg3a5b3VX/TgKgUzCVdYyx+0t0qZap7C5ZWBSPc4auJ8suAMLRMAWYiFOgU1w66MJRq6WG
 adjiT18wDSaPDFtu1gsOAFZrrSSg/AROz7egCwWKe7ic//TBcCNWDHKNBj41eBwUCq4WtnqGDNo
 hOz1mwAqGq3km8idx+yWU5gRyjhRsfAr4Aqn05Jslef6cNcaTPOU8/JtPpgpBQIJSV1DC8e/wUd
 +uccUPc03/MMnHQbLqPtkrMA=
X-Received: by 2002:a05:6808:1920:b0:4af:5d69:1cb4 with SMTP id
 5614622812f47-55be8425131mr416523b6e.15.1792713224378; Thu, 22 Oct 2026
 16:53:44 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:43 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:43 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
References: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 16:53:43 -0700
X-Gm-Features: AclHuK8-qcpXIf5aNDJV3-VgqNSawhsfJu_P9zwcCwRPpR4LtyG_N1LE4kfSomk
Message-ID: <CAJnxHshB_5zNm-PzL9dK=RjRWs6NyaW5RD39TAYnj_=pfr+POQ@mail.gmail.com>
Subject: [PATCH 4/6] efi_loader: capsule: check the certificate length of an
 image
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: multipart/mixed; boundary="000000000000ec7b89065e769283"
X-Mailman-Approved-At: Fri, 23 Oct 2026 00:13:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ec7b89065e769283
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000ec7b89065e769283
Content-Type: text/plain; charset="utf-8"; name="0004.patch"
Content-Disposition: attachment; filename="0004.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1c652b0c94a3562f_0.1

ZWZpX3JlbW92ZV9hdXRoX2hkcigpIHNraXBzIHRoZSBhdXRoZW50aWNhdGlvbiBoZWFkZXIgb2Yg
YW4gaW1hZ2UgYnkKdGhlIGR3TGVuZ3RoIG9mIGl0cyBjZXJ0aWZpY2F0ZSB3aXRob3V0IGNoZWNr
aW5nIGl0IGFnYWluc3QgdGhlIGltYWdlCnNpemUuIEEgZHdMZW5ndGggbGFyZ2VyIHRoYW4gdGhl
IGltYWdlIG1ha2VzIHRoZSBpbWFnZSBzaXplIHdyYXAKYXJvdW5kOgoKLSB3aXRoIENPTkZJR19F
RklfQ0FQU1VMRV9BVVRIRU5USUNBVEUsIGVmaV9jYXBzdWxlX2F1dGhlbnRpY2F0ZSgpCiAgdGhl
biBwYXJzZXMgZHdMZW5ndGggYnl0ZXMgb2YgY2VydGlmaWNhdGUgcGFzdCB0aGUgZW5kIG9mIHRo
ZSBpbWFnZQogIGJlZm9yZSB0aGUgc2lnbmF0dXJlIGlzIGNoZWNrZWQ7Ci0gd2l0aG91dCBpdCwg
ZWZpX2NhcHN1bGVfdXBkYXRlX2Zpcm13YXJlKCkgcGFzc2VzIHRoZSB3cmFwcGVkIGltYWdlCiAg
c2l6ZSBvbiB0byB0aGUgRk1QIGRyaXZlci4KClJlamVjdCBhIGNlcnRpZmljYXRlIHRoYXQgZG9l
cyBub3QgZml0IGluIHRoZSBpbWFnZS4KCkZpeGVzOiAwNGJlOThiZDZiY2YgKCJlZmk6IGNhcHN1
bGU6IEFkZCBzdXBwb3J0IGZvciB1ZWZpIGNhcHN1bGUgYXV0aGVudGljYXRpb24iKQpGaXhlczog
YzJjYzYwYzFmOTNiICgiZWZpX2xvYWRlcjogY2Fwc3VsZTogcmVtb3ZlIGF1dGhlbnRpY2F0aW9u
IGRhdGEiKQpTaWduZWQtb2ZmLWJ5OiBBbmEgQm9iaWxsbyA8YW5hYm9iaWxsbzNAZ21haWwuY29t
PgotLS0KIGxpYi9lZmlfbG9hZGVyL2VmaV9jYXBzdWxlLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9saWIvZWZp
X2xvYWRlci9lZmlfY2Fwc3VsZS5jIGIvbGliL2VmaV9sb2FkZXIvZWZpX2NhcHN1bGUuYwppbmRl
eCBhOGQ1NzYzMGE2Zi4uYTNkYTIyYWEzOTYgMTAwNjQ0Ci0tLSBhL2xpYi9lZmlfbG9hZGVyL2Vm
aV9jYXBzdWxlLmMKKysrIGIvbGliL2VmaV9sb2FkZXIvZWZpX2NhcHN1bGUuYwpAQCAtMjcwLDcg
KzI3MCw5IEBAIHN0YXRpYyBlZmlfc3RhdHVzX3QgZWZpX3JlbW92ZV9hdXRoX2hkcih2b2lkICoq
aW1hZ2UsIGVmaV91aW50bl90ICppbWFnZV9zaXplKQogCQlnb3RvIG91dDsKIAogCWlmIChhdXRo
X2hkci0+YXV0aF9pbmZvLmhkci5kd0xlbmd0aCA8PQotCSAgICBvZmZzZXRvZihzdHJ1Y3Qgd2lu
X2NlcnRpZmljYXRlX3VlZmlfZ3VpZCwgY2VydF9kYXRhKSkKKwkgICAgb2Zmc2V0b2Yoc3RydWN0
IHdpbl9jZXJ0aWZpY2F0ZV91ZWZpX2d1aWQsIGNlcnRfZGF0YSkgfHwKKwkgICAgYXV0aF9oZHIt
PmF1dGhfaW5mby5oZHIuZHdMZW5ndGggPgorCSAgICAqaW1hZ2Vfc2l6ZSAtIHNpemVvZihhdXRo
X2hkci0+bW9ub3RvbmljX2NvdW50KSkKIAkJZ290byBvdXQ7CiAKIAkqaW1hZ2UgPSAodWludDhf
dCAqKSppbWFnZSArIHNpemVvZihhdXRoX2hkci0+bW9ub3RvbmljX2NvdW50KSArCg==
--000000000000ec7b89065e769283--
