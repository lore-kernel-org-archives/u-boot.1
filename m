Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D96C00A94
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 13:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF8088190;
	Mon, 15 Apr 2024 15:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jv2BCvYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B19881AE; Mon, 15 Apr 2024 15:00:57 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECBA688137
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 15:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yasuharu.shibata@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e65a1370b7so10008025ad.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713186050; x=1713790850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AGx8sJU/As6Drl3WKJGTy21sRIyx89B0+r38bVX6Pqs=;
 b=jv2BCvYdnWt2r/+S9VO0GbzlCgv9gvvsoN8s53bf/QAnWosXx9AnZgCfvY1C4qcM2A
 unmFhsABM+3W1suv/QQCokJtBKAjnDGTavRdCPQKzQ1qX/aa6CgNZToVOkP+vFkhCg80
 k1vVncvpspiHztlHX4GjW0M6M/DjvXKLsuXBx+4kVFvm+S1AWooYQ7pJzlidkwjmo0TN
 nvQQKSO/abz5iZbFYOnz+GAkPDk8cU95D2BTc4dkq4ZF52J3rtqBAvMvpUXpiTIKND81
 ljXnxOQ/f58Ql0FBNIOsWRKlzHMwUdzAd7ALP2ExHpwGIHT85jdRaUf++AGk5xdDjtzq
 12eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713186050; x=1713790850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AGx8sJU/As6Drl3WKJGTy21sRIyx89B0+r38bVX6Pqs=;
 b=XR26oz4JtjWMbKyIOAdsT+LhHnmnUI4utaa+vpjmcSavE7NENVpZEw8Z/kQEhsxwL5
 EXhz3CzBzECU1GJ1g0wL2WiDJyqG3eiSNTe9COofGMuT73o//2KEQA25Iy8ctHEtFJYw
 XBMZEvT0P/Y+DYecDamxIbqADxR5OW2Q3M8VFt5I48pq0d5lVGzm1FhS8ClV8HOVlFzS
 JryEfaLdVdQNnljOMDzYXkaNzbWPTX2kAAErujmwMS51Ghwi3/kSOfIbwtlolWVIFBdc
 M34FkYdLIrz4OzTIX3x+zBMnWJgCCfusS3xMWvYQPkrv2RJYgKIbzqdzRJg1Fcmxz8IG
 SAkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViP7SSpYeoqct+50zxrJiALA6aW6ZqKnPKmdyQ27ginRrqkNcaqBCIvx3ez74nVNSC0CH9FO8ranUepwkMdq/dEFnL8g==
X-Gm-Message-State: AOJu0YxtP8pyGUypfwDuest6iqN2uuwcapH50N18HMWH80avNOLHHeUa
 LRKPIKrw3BTVOuY3TGDOmqvCew+9LNt6kYnpNcGDAGpKc1+VCiUl
X-Google-Smtp-Source: AGHT+IFnKLFnKPVCw6O7+1iAfw7g2wkujvQk7ciaEOhmaG+MassMoC+TSaNIZX/2amCcVB2Qj5DFwQ==
X-Received: by 2002:a17:902:e786:b0:1e6:3494:61fc with SMTP id
 cp6-20020a170902e78600b001e6349461fcmr4452441plb.0.1713186050256; 
 Mon, 15 Apr 2024 06:00:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:d8a0:1500:d0b1:1308:35d6:2c38])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a170902c64300b001d8edfec673sm7851075pls.214.2024.04.15.06.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 06:00:49 -0700 (PDT)
From: Yasuharu Shibata <yasuharu.shibata@gmail.com>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 0/1] net: wget: fix TCP sequence number wrap around issue
Date: Mon, 15 Apr 2024 22:00:12 +0900
Message-Id: <20240415130013.26721-1-yasuharu.shibata@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
References: <CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

I send a patch fixing the wget issue.
There is a wrap around issue as already mentioned in [1].

The log in [2] indicates the following packets.

- Success packet
Packets received 64368, Transfer Successful
Bytes transferred = 93198937 (58e1a59 hex)

- Failed packet
Packets received 64368, Transfer Successful
Bytes transferred = 26984682 (19bc0ea hex)

"Bytes transferred" are different, but "Packets received" are same.
First one output by net_boot_file_size that is assigned at store_block().
Second one output by packets that is incremented at wget_handler().
Those differences are caused by the following line.
If tcp_seq_num is wrap around, store_block() isn't called.

```
static void wget_handler(uchar *pkt, u16 dport,
...
                if (tcp_seq_num >= initial_data_seq_num &&
                    store_block(pkt, tcp_seq_num - initial_data_seq_num,
                                len) != 0) {
                        wget_fail("wget: store error\n",
                                  tcp_seq_num, tcp_ack_num, action);
                        net_set_state(NETLOOP_FAIL);
                        return;
                }
```

I reproduced the issue and fixed it with the following patch.
Please check this patch.
I will recommend to apply patch in [3] with this patch,
if packets may drop.

[1]: https://lore.kernel.org/u-boot/CAOf5uwmb0vJOwSj81KvfWpK6yobyz0Ozm5vDGCa9K0rZejbZLA@mail.gmail.com/
[2]: https://lore.kernel.org/u-boot/CAJ+vNU2U9W2NRT6hf1CAEQ_56SDQviUEzuDD1iYOpdf1CNaZBw@mail.gmail.com/
[3]: https://lore.kernel.org/u-boot/20240414104607.5966-1-yasuharu.shibata@gmail.com/

Yasuharu Shibata (1):
  net: wget: fix TCP sequence number wrap around issue

 net/wget.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
2.25.1

