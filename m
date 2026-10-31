Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64215606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DpO2O0+6;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jy8oJIKU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E030A81140;
	Sat, 31 Oct 2026 06:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dbMLZEbeh0gP; Sat, 31 Oct 2026 06:16:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 03A9D81134
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793427413;
	b=mbihihec+ODEMH6+h8FybRwlzg/Fm8UYiVFrMRYUHH0Fyv+MNPOoP5MJcW8FDLfv7ICK
	 q70Jcn2D35EgLrUED4epzXxU5TfBVAWlaN96oTzePHpw/+r3Tjd/4bAEHHT43nws0BmV3
	 nMxJmY6eD4L9wqwThodsN1tXYoWCLaqSxXasJfeZv9tTQ0dPseC4XZVgtSvNn+30r9Eqk
	 TlWd3Z/gDBA2Yb2A1JsskwktUt5UqO2tGJvrgeImAAWsq2VwNPk9mCnh5QNinG65RELL2
	 xGWTqfg6rNlxzs1xW8BT5i6NB2XWVmBNcRqVq/obudJUjcyIIxxsc1ieNqBh2gL9awQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793427413;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=toYt1L7lUIrNc+IaqlJvY5VtYaiDpVNNcIQ1JDrDOPQ=;
	b=kgZADymec534dp4mlV69LbBXZypREEM/esn2sphdlGrGhIgZFeLiruAijphFrcsHwc9b
	 3b2+I4PtOscDLfKC0yVHFvtgATNx6zjqRaa/NagmEGNORmQxosQL4FgnwU3zGUQWFXZ/+
	 vwNQ8S7iNCKoAiqc0pvMFmac0lzzBf1uB6MgCBStxZrBcsxEgZH4CABDJyakUWkpbJu75
	 q15PHO6WLKs+Ji0zunoD3KzK0mNZrKb+trlYc05uNAG+Vkec4RgxJtMC+laywE2dxJ7fq
	 8Kuh84fKK489H4AzzuRNd7MOfzlid7Ij19N4ckIDKwuPZbhf1SRqg8Xsh6at9HGoSlw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793427413;
	bh=toYt1L7lUIrNc+IaqlJvY5VtYaiDpVNNcIQ1JDrDOPQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DpO2O0+67N+ntsPINRCZHTkc543Xb6Ifs/oJ8b3dd63xpi6pCc7iS8QxvPgwwI5FL
	 AG7HtoO0Nq1Yi3CQRnEAfjQoG/G8ng0en9NlKN6lVmrqS+R+BLdTcZaOMhYUeNCyDk
	 NPk3L1WAspIRVQX7o99nD+gmyZjTDwgv2lbPmXBegCl2XxvxioW+TFiQ2W6gHTTb9V
	 Xrh9deyWHEH1EYeXGtEs9AE03Mq915bZccwxgoekjEQFXydkwYVBCIC8czEIE7EVES
	 Fok2bS1fk/kcs74YErFMqWq1/y3fPCGKUTl4xGauiucvEUBxbBouJaSekkhQXn4hMD
	 RSO9dEUYMublg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03A9D81134;
	Sat, 31 Oct 2026 06:16:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D4FF156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1324540B0B
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0ToSowW48I8 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 06:16:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F0F7140B0A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793427411;
 b=es8zADLDZyyLbJQGZ8ioYUxqwv91sQ2HELBErATNu2uzWSVOdTqjHG60D+bvK9PKi4BF
 YNPftbQupi4nS+pbY0id83wq0yZw2ORxUUCi+qFvH3oB9xyuVDwlsEQ2BDzfaA92/dMt0
 XCPwKSQraM5DgOzj+gyGepk2O17CtKLPP5VZwLdZmtI0NdTrTdXEtHh4924H/QxCdkGwe
 qswvpX0+DtIZXNYuix9DA1UN9xG7T4UW7brPMKuPfVeMROQZZ6oiPVrDpHBxFs+FUSrob
 97rvDhH0yWZaNNGT+zWgZY26+SkM1sKT1sQVG4fVhTPcl8CLZ0Tx+s2xrB09HrSBJfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793427411;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=toYt1L7lUIrNc+IaqlJvY5VtYaiDpVNNcIQ1JDrDOPQ=;
 b=cRKSLWew/EaCFmJKAKlOs0VSajS3s/diSxteaZoUQg9sL8vQwFSS8e4kgFGonuooVCYs
 6mdpRwrgw8BI964WTsYVowVtnUYuT8UfH6Z6zWKLSriYVQ1N+I5CsabHR72u/iDwX65po
 8fcupqJ1cNjw3svs6HeZpK5fkHTQhS9RbRrBxlicCF4oymsSl5++1X89AsR4HvE8zJoT8
 4geG7hg95qeKTteDblgTQYgMyAwXzrbB3fI9CA4USyH0OCySC9redyQS3QTTfnx1TzRU/
 U7EKpbmw/rdo9lA167ljHJVzvaG5f7venl5exXdPATL4+bmottH9MG6/M4MjqJi+E4A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Jy8oJIKU; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Jy8oJIKU
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F0F7140B0A
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 06:16:50 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1485003f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 23:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793427409; x=1794032209;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=toYt1L7lUIrNc+IaqlJvY5VtYaiDpVNNcIQ1JDrDOPQ=;
 b=Jy8oJIKUCxC/8ECzxFsDuoBpEwEQYgQpZPd0V0hX2tCA6t9kJSlqxpfHZzT4bxC0AC
 r1+aMCA/DCw222bEh72496qJUH3GXfAvKIR3YSkyVVXBYTikW0xzk1giQBEEIpJGOVhU
 sHQ054Q3PVc3TbOoGFbT7LNkH8jNL0XErmptptRbZjubXEyGgitTfhX1enpqzXQmnBxH
 1PoIdKTSHtWt3UTXLqt+rGuXxo+R7plQ1pBZQZasN2bDdfKcXIXV+5/7456SFLp7w45c
 x0J86wSsyKBFRgJhgoX//SPXDY/e74Hq5dHIvKM/4sF+iY6dpwdNG6swTFyIQEOuQlja
 GVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793427409; x=1794032209;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=toYt1L7lUIrNc+IaqlJvY5VtYaiDpVNNcIQ1JDrDOPQ=;
 b=KqvAe4ZS6JMvV7eckDeBm3XiZGUrL8pM3QqK4z/ERUMVnrf7hxMk1O8CvqP8yVS0SR
 5LObFrctLh+/V0z/3/yjP1ZJXPSepHCPYqNakZYqSgws+fd6M8HDpzuDag3LsYrdL6Fd
 TnKnNYNxGKmfpk7tc7unqjLxPkYDDA0jF7Z/5pjEFsqrWRgYUfVUwGtUcLbt5l7imX/1
 uDE7ygF6rHAXPEjgLh8GQTprvReNqVnOyrPiLCaE6r0lv1euT4C/r5njBZKoSpbPlw9j
 rKg6Ip9ftsefY3ZG/9fcEKJCGG4KpUUWFn3mUAmnZD8E8OQu5TsDTdnZqYf9uuSejlfb
 JFXw==
X-Gm-Message-State: AFq9FYKt3MgUERc8A2WPUmxiB6I7SFeCsB0Xyi6BvMV2W+74y2NQMZud
 efxDit36nezKHDKYaFEfNAYCQjnKcYmjG1rJF0KcWAozHTQfHRTDRUd+
X-Gm-Gg: AYBFou2/MOM0vm9ekqpZYuNNsSCToZJAz4wqKlfWTe2OIu5CWdoir2SDbbdsxAoToS5
 WwGROOVdFeSweDZDhl92+69B+jhtkVZ/tU7Dr7sRpcw6IYlYJD174JJD9arlwR6uZaIdmE9RcuZ
 vvNMqoMIqVeLEKFxPo5XaXak7A7DwoT15iltPg9jp72stH1grbO3ad7h/PLr1zjsbZtT/MKSZAl
 o/i/SzURNQGTYlk/spy5WaWPjoPRXlfiab2kYqlQSARr68uvpPMmRNHhxuKzqKJTAcOqFCKWm0v
 djja4rV48q14wTSVM60YEE3WB/1ts7h9/dZg52cWvYb+L70v7yJxkGSaEFN6ZpIiFph54QJEEPp
 p12E6xBbHM56ydDSvJ8CLh+UCb9URUC88GxyezRRNv050p0/BRcN/hctKVgcAI1xU1FppTJu3OX
 AEskug45Zj/9KN5vv8E3enQZnaXr9sadFUfPB8BwG/CkYBvkbBLEX0Tvd6l0xjTYelTDPWJx9Xk
 rEfzZuVnXapVvyMMyjlNKhlYPAt684XnSGm+CZiZRxc/vi4GUihTa0LJJipT3BrM6oEbNa2OHOc
 6T3wtQT9e0Qt4F4AOabuop/e/N28sSA=
X-Received: by 2002:a05:6000:26c8:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e6e3040a3mr9866766f8f.20.1793427408435; 
 Fri, 30 Oct 2026 23:16:48 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78f95sm6383909f8f.28.2026.10.30.23.16.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 23:16:47 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/6] usb: check hub port and descriptor counts during
 enumeration
Date: Sat, 31 Oct 2026 06:16:46 +0000
Message-ID: <57123e9b-629d-49d3-b500-095503129ed2@gmail.com>
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
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

U-Boot takes several counts from the descriptors of a USB device and
uses them to index fixed-size arrays without checking them. A device, or
a hub, whose counts claim more than it describes, or more than U-Boot
has room for, makes enumeration and the class drivers read and write
past those arrays.

This series checks each of them where it is parsed:

1. USB_MAXCHILDREN goes from 8 to 31, as in Linux, as xHCI root hubs
   often have more than 8 ports
2. usb_hub_configure() uses at most USB_MAXCHILDREN ports of a hub
3. usb tree, without driver model, no longer reads one past the ports
4. usb_parse_config() lowers bNumInterfaces and each bNumEndpoints to
   what it stored, and keeps what fits of a device with more interfaces
   or endpoints than there is room for
5. usb_parse_config() skips endpoint descriptors for endpoint zero,
   which xhci_get_ep_index() turns into the endpoint index -1
6. usb_select_config() drops a device whose configuration can't be
   parsed

The tests for patches 2 and 4 to 6 use the sandbox USB emulators. With
sandbox_defconfig and CONFIG_ASAN, the five new tests fail on main and
pass with the series applied, each patch builds and passes the tests
present at that point, and the whole ut dm suite still passes.

CI: Azure build 13714 passed, all jobs, with this series on
https://github.com/u-boot/u-boot/pull/1064, a CI-only pull request,
merged with main 3973f3c4d24:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13714

Ana Bobillo (6):
  usb: raise USB_MAXCHILDREN to 31
  usb: hub: don't use more ports than USB_MAXCHILDREN
  cmd: usb: don't look past the last port in usb tree
  usb: keep interface and endpoint counts within what was parsed
  usb: skip endpoint descriptors for endpoint zero
  usb: don't use a device whose configuration can't be parsed

 cmd/usb.c                      |   2 +-
 common/usb.c                   |  38 ++++-
 common/usb_hub.c               |  21 ++-
 drivers/usb/emul/sandbox_hub.c |  40 ++++-
 include/usb.h                  |   2 +-
 test/dm/usb.c                  | 262 +++++++++++++++++++++++++++++++++
 6 files changed, 350 insertions(+), 15 deletions(-)


base-commit: 3973f3c4d24df75ca90d7c0a9f03e5e5c9b48f32
