Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85026CCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C279E6064A;
	Sat, 17 Oct 2026 13:01:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YzIrB4-yJcK8; Sat, 17 Oct 2026 13:01:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E0ECA6063A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242076;
	b=GrMfH9S2rQTXSV8JFNWbjnk8U/rCCt8cdri6fCkii8JPBeK19Q8bEDt6mKxCc1usWIww
	 akXIUUZ43U5iqc+nYKr76Dh8dXF0/TYgF6m2RM/faa0653Soeg8K24100vTwzvEL50nPh
	 trcStxacrDzPSyVxevMf9B8j24n/urPySORVZ79/eWk7oSZ85RrspNcp34II4gvIiahmp
	 w5CxdmwzfEVMjgP6TXLlD9x0qCBhIinQe5k29hzkDXN6bQT540nLyyJ+5myqQV75d52Mm
	 bIRmSpHxet1x+CJK6wEFnHj3nQRYu3PCTBC9fevNlr+t61eLMjC5m45ep5Ls8yNQlUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W+HVf0EdBOzrwJWbJPAYMD7xoH8c4s/GlHgnjy1ZIRY=;
	b=YLCRc53H0wlPRss+iHxc8VVd1pcBviSBp4pPWUervEaMSCcHHT2+UT9qPcu0fQdvPypH
	 lS+oFm+aJ6mo8wRwNrA8rAPZRHGEHsdw36XhfygRDshteoHlEpsxGC6vAOb8jGKxipWGL
	 a7FPL9gPwmYhYygxsJ4NYSOzlfaAi2FOXPg6+4+40Il58Y1+Li743CNUTE7YRclum5o7g
	 KF2VrDdj48iXalX7JDj9LoCCug/mU2ZQmHMPvXX/aEZ450VRSkBCOzvCFFlHM906aw33m
	 FffuifkLvzy5W+y2fxdWDu1kQrBTdCgUAmuSFdEkMvPDOiy9Q1InVQBVaG31eJi/19A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242076;
	bh=W+HVf0EdBOzrwJWbJPAYMD7xoH8c4s/GlHgnjy1ZIRY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=atr1Z/M/2f2ZYu/6aSge654jz83r9cqc3nxy5BJz34yC0P0GtTUAmyqIKPdQIoWPA
	 JrN/7wS5w7WBYm6oyrXLBbTmyL+E5Zce1AGZZU3RXPZYrG/06gtSiRqbC+4Cf4qj1i
	 EjpxF3/13rDy+mzja/oY6GnHtdhIE4e3UoPH+WlZQQRPZ+jlxHytLKqA9qge4LCjne
	 gKhQj+ykUoUIAWjy0rFU5CKjqMwg8MtqmJZ5icvAvQ3rrjxAW0jcfZY79gs5KIhkM1
	 S7XTmXn87VSTzU/veDybk6e/9aSXxp7ifW4jZaiN/D2ULRfIqB7Yghn4kToH0xE8fG
	 SRWJfoMqcMnLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0ECA6063A;
	Sat, 17 Oct 2026 13:01:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DE5B1AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 542DE812D6
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3fO6CWwVtlub for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 12:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CA25B812D4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792240590;
 b=nP1rD6NFEzWph/Dl1+AX8JUL6S0ecjkATp6XTDp2ky2pAEISblBFzz5ehSC02l/5GZL3
 yZUFVmVMpM9/2mGQ8V4sj829CWj3G6XUCDk43NB5jSlCFMf1NyfaEwvzRlQNzGNVlPTUt
 HSF8y7OJI+2eFQkrgyPcIDkPduypMtaLjlIPvoNYq7/pzG5gIawPNzJecZQ08jhlcIEBV
 z5fNuDA10zC21F+kbZWDmDtt6Ck3TGcPImgpAc6pyYr4KCHBYrVyB1GxxNLXEHMWr6bBF
 HCixerH+f3jOH7eP1xvocpvmvJJF7ss2GCCbltKKspRnEc/DbFhUzHwcmE1uwvMAyBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792240590;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding;
 bh=W+HVf0EdBOzrwJWbJPAYMD7xoH8c4s/GlHgnjy1ZIRY=;
 b=SQzfnIHMaDp8/1n9f7SNqU1J4Kf1OGTYjVq/lOhum9jMH0oTkynVeNIxKvestuz24Hha
 JyMTFuMYYaHOTqWRsq8i1fYSZVvhqUEuR2bImJBg+AS2czFSBtYCiifKM6STaQts86OhF
 ND0HMplvSQYhYmCCjX+tEBUhhFDrkKSsZv9hvO7KPvIkNxqbpvYFk23KGha3Bw0OsK83R
 qVH+cNkyZ/qnxkPpV5IJiYA4BzQv0+Tv9uMJoNGCj1am4vtNNxdWz4iVXYH6L2Gj1fGB9
 nZlH+odUMrGdB70l/NEG8DkJhtKGlKYVjOIbreQK6PFwMdWl1ngUu4HYC9Sv5TRFElA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=canonical.com;
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b="l/ntmhiC"; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=l/ntmhiC
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA25B812D4
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:28 +0000 (UTC)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 329923F162
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1792240586;
 bh=W+HVf0EdBOzrwJWbJPAYMD7xoH8c4s/GlHgnjy1ZIRY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=l/ntmhiChMvgajqa48VXdrrhTrkdtFOrQVV52/42WLzwgdYDJBK4hd8NsIDKJnDxS
 /PUbW8WidPFVbmGENQXv2AVPE45sz38EyutkXy6VVdtfvbmkeaFBfpq3ii2AJ0tl2A
 4HlAj68ziQA4N/8u9cGPOuuaSigGJg5uNFhNYnbSJtWMcwxUoM5/WBVjx1DoL9fBRP
 iRDxbYb1kIoo0/blIz/XEY2n1uPOQUYsoLjBrU8kDkffden45SN1tlHrYk8SF5/Dg/
 hI1dbUtJAOFVr9TypDVZmV0ZzNPNs8xtfslihJka/g5vwFT0BKIBL+csKEhvW28NLi
 r6MOWzauKxyktz8XsRvniy6WwM4g+VgfxX+qCOIT0whTfdppGW7zG6ilwJYAaTTj+V
 BHAvxxy3KUkvRVoIDs1efuU2xE00vltC896NLVptMLD+AcwtZzWnxiM2R9gmIaTMfF
 8LfUMw4agPeI/pSJkRf+SWexqwgKjd9FqK89Pt8R6EObmZUj2Swy6zQhdmsAZlEQNo
 ciE0jfrRgz3p/lr0FllB+nABGSohatizxUH9xeT5CbLaevvkhuu4Wa5jXJ24li/vQc
 VJcEeWfvnN6t0cThjbb11rSv105/gW1QgHMd/pjBA1bdeeKoeyjjF/fkbcx5x8MXTj
 1FEo8TtzxXSSSLnozhYB+SHU=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3aaee1fc104so1224868a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 05:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792240584; x=1792845384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W+HVf0EdBOzrwJWbJPAYMD7xoH8c4s/GlHgnjy1ZIRY=;
 b=D3ge25a1BGX17b8IiBM01MwlXDzDJ6q47U7F8hB56JiO7kJ+ImpEGSAkZELmNOnCV0
 4Ot6Pjy7lYLp8g7WfaIzxrElRd8c/6Is9v98cocfDfRq8p6cAdn4pPVu9Gl20CDmlnB+
 HggmIJUWjSpuf5MdfNRUEmweh1xwxrlDVU0LTn/X4RLB57V1TFKivUw3zPeI6/uoVyeR
 vPWH69Jmq5zEk2xVLoe9pd4ykOBN8wde+nhcQOf7aRZqgYn/weQEBlg/qHghYo18TFh7
 4ZRAuSiYlA/c2BDAUoP4+ePrVfoLt7K6BjmGSmMaTrLYRujOt0Q4/zMZf4cjLxw+5XUS
 ChVQ==
X-Gm-Message-State: AFq9FYKHVsnTKIglqQhMEpFP9dRbviRwo73KLs+hGguSBxeVv4QLABI7
 srZAqLruOI6kr/VgjycYrJY4x1HqY0J8ciBFYCzsQtabBrhHGVR9xGKSbKJeB5z6GPpYdSWAVZy
 tesxfPGFZhscTmUECi03kwrw+k5/GlyPO8UtrYVldM5ipDE5DjERrgxvYu+Nbxf/npaS6acC2Jl
 U8yVthHuiqFw1r/8K/LA==
X-Gm-Gg: AYBFou1IHb/N7f7njyC8hx6cxAlH5NlUmY1eoWxqk2xlgC73Q1FuyjPUcBgFigVPprL
 XXJ/3a1Q3v5BdQz7NIxKh326B5XKd6S8tMWTVS0H5/r9d8giW9x/tVDZ6qu3ljJcu/NsOA57aeg
 qUJct3UDhjnUnD3V7TGHzf4kZwmKidmrUOCvYDwZqzgL4LXxcgymDOrxrCSqNSfKal97q9q8NcU
 EbiDApoOoBd8+P47jC28OgFrkux/DyhxOSA/hDz2P/d07uZ471jGVdamowzde3Sf8Iz+TUsOcA+
 TmtvpncS4tlU5fucLshPKuNxxUzFntEy2QvrSeUZgW1dmn7aGAgW+lLOQE+s+Y+G23Os7rvPaQb
 Hvd66KjO64hz5qrlluWSwSfzPgG7tbpEXcpDrMZujNwF1JD8=
X-Received: by 2002:a17:90b:5743:b0:3a8:cc4f:3475 with SMTP id
 98e67ed59e1d1-3acef60db08mr2420561a91.60.1792240584337; 
 Sat, 17 Oct 2026 05:36:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5743:b0:3a8:cc4f:3475 with SMTP id
 98e67ed59e1d1-3acef60db08mr2420537a91.60.1792240583869; 
 Sat, 17 Oct 2026 05:36:23 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc48f4cadsm7909410a91.12.2026.10.17.05.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 05:36:23 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/6] cmd: pstore: fix out-of-bounds accesses in display and
 save
Date: Sat, 17 Oct 2026 12:34:15 +0000
Message-ID: <20261017123554.211799-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:14 +0000
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

pstore display and pstore save read the records that the Linux ramoops
driver left in RAM. This series fixes three ways in which they access
memory past a record or a buffer. Each fix is followed by a test in
test_pstore.py that fails without it.

Patch 1 checks the record header. pstore_get_buffer() copies the bytes
from offset start to the end of the record, but only rejected a record
whose size is 0 or larger than its zone, so a start beyond the size made
the length wrap around and crashed U-Boot. The ftrace records are read
without checking their signature, so leftover data in RAM is enough.
The record is now rejected, as Linux does in persistent_ram_post_init(),
when its size does not fit in the zone after the 12-byte header or its
start is beyond its size. Patch 2 writes such headers and checks that
the records are skipped.

Patch 3 fixes a heap overflow. Each record is copied into a buffer
sized for the largest record on the first pstore display or save, and
pstore set changed the record sizes without sizing it again. Patch 4
makes the console record larger after a first display and saves a full
one.

Patch 5 looks for the newline that ends the header line of a dump
record within the record. strchr() went past the end of a record
without one, the header length got larger than the record, and pstore
save tried to write almost 4 GiB. Patch 6 cuts the header line of a
dump record.

Without patch 3, the test in patch 4 trips an assertion in the sandbox
malloc checks, which stops U-Boot with "### ERROR ### Please RESET the
board ###". test.py treats that as fatal and stops the whole run
instead of failing one test.

Each commit builds for sandbox, and cmd/pstore.c builds without
warnings with W=1 for pinephone (arm64) and r8a78000_ironhide_cm33
(32-bit). All pstore tests pass on sandbox.

Aristo Chen (6):
  cmd: pstore: check the record header before using it
  test: pstore: check that records with an invalid header are skipped
  cmd: pstore: size the buffer again after pstore set
  test: pstore: check pstore save after a record is made larger
  cmd: pstore: look for the end of the dump header within the record
  test: pstore: check a dump record whose header line is cut

 cmd/pstore.c                 | 20 +++++---
 test/py/tests/test_pstore.py | 88 ++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 7 deletions(-)

-- 
2.43.0

