Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D0606A319
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MCdhRM1C;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RUFwyCUo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 457B1409D7;
	Fri, 23 Oct 2026 00:13:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9q41r4UvdTDZ; Fri, 23 Oct 2026 00:13:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F62840979
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792714388;
	b=E7neY4S+lMncUn5e6ulLrG/WqLV/tm8A9bfBkvrnWzcbGlPmBThyLVRJlSXIjFy6sfBQ
	 UoV9oVNIowjTNIuBtCLt11D6rS3BOduggtez+0T+P7BxyIobcyAyW295VYnZQVm2eKbsk
	 7SL152EmWfH5G1U9nmP/5DBYerEOQeyXKVtpZlK1d6hYWc0EPMgOtOCNTKejxIAuYb1Qp
	 nzE69zDt04rtsK2VoIz2ON35qCHRUilI7MLMdkFbjVrBuXyfPUBGCFJ0ANirc/cxx1YDQ
	 ivlydnT846EWPNIvMZD6fg4f6N2bo8WoUQnWY2q84hjMA4Rf0Zy4XRNTD3uDZpJiTrw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792714388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IDABvPZnnJLYzSYYoeOOKMZjmAS/nN8nEqvvd6hkpXY=;
	b=XFoD5EYfkaYg+SL+kV0Y+c8ZhRA7OZI3Dgvsem7+LIDqYWj/2230fH1kfMSVfRDP+9o5
	 uusxAtbBpBAxnV4gsoS2qOVmCq/va7+/oSExiXuoEwf3PbdfJbOsBeuissGlHqrmqokSx
	 wCtL5gkVBt2BsPCX7rKSTXwCZ9cuSPo8ksVuxcmp50gX2J/lHJgxx1jmAJi/mx30DC0YW
	 P6fs6RZ4j61UAiC70EzRK6bNzTPkNJcLDvRxP1ZJiyruZAzw8g2YR+bsw+blSyGncLQCs
	 7x/hjUD+lYjbyuvafln1jMkbbpO+mLQE5XV7cCFG22UU981uuXeyTItWDyx6tUre1Eg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792714388;
	bh=IDABvPZnnJLYzSYYoeOOKMZjmAS/nN8nEqvvd6hkpXY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MCdhRM1CZ+EV1QFbpXyp2KxiiXMR8tuyzMpFPJFWHW8y+0h47lK4g7EVuA9+8GVys
	 nP9K1Zihigu+5/hbk+oqM4RJalHt/tyeSGxycNEclD9Hdj+g1GOPpcZZKK+Fu2WI31
	 Bpq9giQghQtLGAGJwl8uH1xxBdBjiuCJe5EtqFYS5JFjHw6Tx5kKAt9J1QKxthBhNi
	 jD5YrUlqw1fe4tMOxxQ2hDi7E1DDaf9+HSkPtcXl9yRhcUQH7T7CBWGUjCoMPIoVXl
	 wLXEJnLbCObZVhsWZ8pt0NRGoXYbxHD0aezetyZQ7H44w44BAikvK0Wv6icjzWSP7p
	 MOHrq/zKnsFew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F62840979;
	Fri, 23 Oct 2026 00:13:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 504ED3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3672E81205
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8MZ9CGjxjUS for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 23:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6FF66811F1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792713212;
 b=GgltinWEUVp4Wy7O8ly1musp/FRsYftUNjpvhgSyQVWR7i6xXi2kGyf8CA+fD4kucX79
 SZjOefNZv40+qTrLaSkOa+/qzXrWfPUT2td1wLe8D++GTgBdzKeBZ2ORxNO/Shv+vWc0U
 mgh+Z1blt909QwZDfpcTuyksTaDyrs35f7HWLOJrfabfWGem5U1hYOG0ni0dtbQ7nUogZ
 4zNA6V9MsNC3k2HQVRCyk+mpmG13zg4KgVCGZ61SmWBQYqRG6vdXyxHHrqoDTq9X4ZWAb
 zVWGG5YDXjv0K7k7kiWE2wmPak1qcnCjlbK92PTXX9xr7MGKKS/QkHMr4ZaqNIrs5Jw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792713212;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=IDABvPZnnJLYzSYYoeOOKMZjmAS/nN8nEqvvd6hkpXY=;
 b=b8WN5CzY3NWe1YJNxPhLI62kBzDTt7/lAwktbO3NhConu9eRserMahBDOUCDigCJO3ld
 wlciZ6c3rZQPyxhStmzp7+xQjt7yvkrm4ZAFmQd0it1GILlXCRAYvDFoLnGjbSl3J+F9k
 UlWv+XeUa+ESQ8L47zcnta3FyDtcqZuuEvGmIWBvIBI0CCcbW69E1ZtHs7pEjn2u3tsvC
 PGzgWg1aQUmGjQeZANnfsPSmrMO49tGFipXM3jxdGU0VIi80nHk8jMWZVPYk7xAHCH3mB
 MgN+ex3re0a9L0xMmTmY1Ia64bNekd/1ZVtbCEx1pE1BK7M8fSbsLP3AX3+qeu0xWDg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RUFwyCUo; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=RUFwyCUo
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FF66811F1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 23:53:32 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-8253bc5a613so191333a34.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792713211; cv=none;
 d=google.com; s=arc-20260327;
 b=Vg8xrpH4TMwCFlncJ0B9Ux1mKKKNU5Szx7LjBKd2NEhi6+WFVQoEUHbRz87+C8bqn4
 H5cFoaokldwFgkwv2mpdK+GUhTYl8kZaBc0Zsb250rXyK1r0AlrT4Rq1mspbZ81ocnvm
 ce6cSMiI7w6RFF/I9Jh+s04syvCYdTD6MXyQzTHAi5u0yx3WqYhIFho/iCJWOYnYXVDh
 vPZAzkxczIUvuEhQ4a7RtA8hoYI2RQ3gEeFG/QuaJ6rKRO+O9Kn0babYRH0uy1dmm4Q1
 hGdWtvyPCmZbD9uuJi+qFDbTha9tTJI1tXXXQp6IzxLXmtGUpNNSow5t8Hk0Tft7/p1J
 esEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=IDABvPZnnJLYzSYYoeOOKMZjmAS/nN8nEqvvd6hkpXY=;
 fh=u4xG2KwCOaAX3LACWiWdBW7foS+n2V4JX1MkoNaREaI=;
 b=LIcssq0oGbABhW3Z8uc7pXJlurvlfK4QRoyBxNDVkGmbC/pLS3ush8N2gQY3fv7wv3
 wy56gAxIUSSSC2vATTNRvpIEk9aTSqCBHs9u7ZRnlK+aI03XxNjVCNyAx4GLBaub7PUs
 uzVPVWL2oCJat5u0P9XCghQXcRfFjsZrWuD1G8ToZbBcDhCarG+UtmEKejtKeaiJo95r
 Kqo5MpNabkmPfoQNhdACaX7LHCep2Q3OxY7G7TtfxzQdKL8+5lmIX3GpqImiE3U82H6U
 sMNvyNrx0AzHkqrahbZrAvSi25tqYUKchgoO0hzvat5krcD1+FLTakWZLfWln13IXL6a
 GfhA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792713211; x=1793318011;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IDABvPZnnJLYzSYYoeOOKMZjmAS/nN8nEqvvd6hkpXY=;
 b=RUFwyCUofV57Ac61sJwhIf3kvyMhfza76q+I/AGLzLwkmTb/gl5Kb8rrz87sjSE7WB
 KmG2nQKs216ZzYH48tJDet0Xade63FGKXIlOJ7tEx6hdSbc1N1XGa4XaF/P4MrhbuGya
 r6JIyYymdtyzMlE0He0nWOcovih0YUMOjeaidxpEU2iNO4LJ4rWbiMpMUAS35OueXeur
 Q0vX0mqUdWEl/eS3WPbfmCHmf7IjAFswfWYRw3BJqKNc4Sk0N6VHxBxotuckuVps+KIY
 rYZuJsT01yTlBxT5rFrHOvjhifNDh4X5jw+nqwdqTKmLS0oSVTz3oXXJntW3WnV5YUqq
 etzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792713211; x=1793318011;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IDABvPZnnJLYzSYYoeOOKMZjmAS/nN8nEqvvd6hkpXY=;
 b=F0NXM8lgEn3KAS1Mm7ExSt/hr55vED1h/QKwvfUIDbsBID36WAwAOwpZc/pMwvs7gE
 aOYftvEImp/03SvtGWSdU8d3w6mXYM295bK+k5DEXDzkloon53nqKJjFbqOddJN5oQlM
 5nlYw2v+/Xxk7kbkxLQp25HFNE02oCcCd34OjjfVUjcEls1swVND5tucTH3GcCy9kAZd
 ZIZVLbTse0LOwP1d1XcZkzcC/qI99QYwGKHQGQsq0/3vxmQbE/ix7P9avqngTZ8+0VSZ
 bjY9M84w1RhS/xjhdxd4vVdZymaar8ytgh1wZo6Y3eS/AsBwKTb61PtkmS4Rj5lbQPl5
 yweg==
X-Gm-Message-State: AFq9FYL8B2HvKte38s7RYaBUJQ5GxCvyMDkZ44QLrBTwVqcyBaY5TEBp
 7d4Kov6Dvvv+lw15rxV9bi2ktfy2wiIVUlnvlBTBMGqgQ7Ief5onZIFYYHPmf/mqVMMfrXGvmVp
 XgUEFEkXT+ppn9catIX1JOUhEh2DcbavLX9Cl
X-Gm-Gg: AYBFou1A09X0PaeuOs2gnEzYuQ78DiTiCvABNY6XTf3dK6ZBChNGLz6gIPYbaAsyKlJ
 S0XWWdL6thgWX0dQM9rSUPETORuEx5Fqf/+VeJaXLl2OG+j6smJxL/YnkixG9d8D4KZw1zdTIVZ
 /uR5SqvJq4xlp/hM4A3LJBdXOaJnlL/clEdM1h2UJX9Jwq7tD3bBnKYv2Q9u31Ogj7RLrmHo1KN
 nudvVH8+jKp2Hx5R1WPS9DIx5+5E+MEX9FyBMtY01la8cjwNJ9IMC5yqzv6JOgRLqGbJDqJJ6Jf
 pI+g5+h/fFNn6Vvj73eNOSNjfZ/fF0OgzcOyOt680fc2HffHaxa890h75zXImOKWORMip1U4u84
 R9EoU7kvpt/LZZAJnWEpCAualuxzNFpOO4itspBZN/v56
X-Received: by 2002:a05:6808:f86:b0:50c:bc6f:fba8 with SMTP id
 5614622812f47-55be866fce6mr399876b6e.65.1792713211091; Thu, 22 Oct 2026
 16:53:31 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:30 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 16:53:30 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
References: <CAJnxHsiYXMS--ZjXXN_pOZMbHyyGX3ANAj=fYSMKvjgjxzeWTQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 22 Oct 2026 16:53:30 -0700
X-Gm-Features: AclHuK8ksuwtARMF92kfaRtWqSyJDZwV3-Dby8vT81uahas6HTndefN71rM2Xt0
Message-ID: <CAJnxHsgDQfpjg85JT4OFUzPcJAh3ELYtFf+JK0r_LJXGHnKYGw@mail.gmail.com>
Subject: [PATCH 1/6] efi_loader: capsule: check the size of a capsule file
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: multipart/mixed; boundary="00000000000021b96e065e769258"
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

--00000000000021b96e065e769258
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--00000000000021b96e065e769258
Content-Type: text/plain; charset="utf-8"; name="0001.patch"
Content-Disposition: attachment; filename="0001.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: c7eb271cf3f5a86_0.1

ZWZpX2NhcHN1bGVfcmVhZF9maWxlKCkgY29tcGFyZXMgdGhlIHNpemUgb2YgdGhlIGNhcHN1bGUg
ZmlsZSB3aXRoIHRoZQpjYXBzdWxlX2ltYWdlX3NpemUgZmllbGQgb2YgaXRzIGhlYWRlciwgYnV0
IGRvZXMgbm90IGNoZWNrIHRoYXQgdGhlCmZpbGUgaG9sZHMgYSB3aG9sZSBoZWFkZXIgZmlyc3Qu
IEEgY2Fwc3VsZSBmaWxlIHNob3J0ZXIgdGhhbiBzdHJ1Y3QKZWZpX2NhcHN1bGVfaGVhZGVyIG1h
a2VzIGl0IHJlYWQgcGFzdCB0aGUgZW5kIG9mIHRoZSBidWZmZXIgaXQKYWxsb2NhdGVkIGZvciB0
aGUgZmlsZS4KClJlamVjdCBhIGNhcHN1bGUgZmlsZSBzaG9ydGVyIHRoYW4gaXRzIGhlYWRlci4K
CkZpeGVzOiBjNzRjZDhiZDA4ZDEgKCJlZmlfbG9hZGVyOiBjYXBzdWxlOiBhZGQgY2Fwc3VsZV9v
bl9kaXNrIHN1cHBvcnQiKQpTaWduZWQtb2ZmLWJ5OiBBbmEgQm9iaWxsbyA8YW5hYm9iaWxsbzNA
Z21haWwuY29tPgotLS0KIGxpYi9lZmlfbG9hZGVyL2VmaV9jYXBzdWxlLmMgfCAyICstCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9s
aWIvZWZpX2xvYWRlci9lZmlfY2Fwc3VsZS5jIGIvbGliL2VmaV9sb2FkZXIvZWZpX2NhcHN1bGUu
YwppbmRleCBhNzc4MTBmYTE1Yy4uNTRjMTE4NzM2Y2YgMTAwNjQ0Ci0tLSBhL2xpYi9lZmlfbG9h
ZGVyL2VmaV9jYXBzdWxlLmMKKysrIGIvbGliL2VmaV9sb2FkZXIvZWZpX2NhcHN1bGUuYwpAQCAt
MTE5MCw3ICsxMTkwLDcgQEAgc3RhdGljIGVmaV9zdGF0dXNfdCBlZmlfY2Fwc3VsZV9yZWFkX2Zp
bGUoY29uc3QgdTE2ICpmaWxlbmFtZSwKIAkvKiBmZXRjaCBkYXRhICovCiAJcmV0ID0gRUZJX0NB
TEwoKCpmaC0+cmVhZCkoZmgsICZzaXplLCBidWYpKTsKIAlpZiAocmV0ID09IEVGSV9TVUNDRVNT
KSB7Ci0JCWlmIChzaXplID49IGJ1Zi0+Y2Fwc3VsZV9pbWFnZV9zaXplKSB7CisJCWlmIChzaXpl
ID49IHNpemVvZigqYnVmKSAmJiBzaXplID49IGJ1Zi0+Y2Fwc3VsZV9pbWFnZV9zaXplKSB7CiAJ
CQkqY2Fwc3VsZSA9IGJ1ZjsKIAkJfSBlbHNlIHsKIAkJCWZyZWUoYnVmKTsK
--00000000000021b96e065e769258--
