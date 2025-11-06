Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976BECCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 09:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F278583B4F;
	Thu,  6 Nov 2025 10:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CqSrlCgu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4F183B5E; Thu,  6 Nov 2025 10:34:29 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05C3A83B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 10:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c69f515220so202232a34.1
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 01:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762421665; x=1763026465; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FjWh8tFnAqfErUdctAvgdIGrUg1u9zlmsQ+gkpAmFSk=;
 b=CqSrlCguvpMQl8i/glSx9Rqi2uHWFwine9IQEPaAMNJX4hPv5e4lea1eXofHGJ4fnS
 xyFcONTu47eMGmB34JXhch8FWltzHvhFrPJ4oQMNteOPobyOlI9FCrYEDkxOt8H/UiKI
 zFKH7lBES7ScIvF+uDanr4ggxk84n39OSlIgL9AxAw2Cktn03qudDV82oZvtnC0kMHnx
 7hHNXIo16jkVA7eA6SVyO9CmIZPdNcCFoLEyTq4Nmmwns68VamnnUJExULFMiTsL3GVi
 Mru9dxSTMRThrsxPiez75om2v0zb1bfwyibqcxxqy7dCDqU0CIgs7Gn6OCHtv/C+uaPN
 iABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762421666; x=1763026466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FjWh8tFnAqfErUdctAvgdIGrUg1u9zlmsQ+gkpAmFSk=;
 b=TUtne018nFuf+WqH2zOrIbUPuW4GMD0eC8jibFfynhVv/PbforkiLGhjgtAnE1EGa9
 Dk6KNDmq8iAGNsv0qnz8PPfEPd/DnujPRBeK2Pd72DQ/kBId1yZAFoRUZr1Ozp4YqJBD
 xyalIRW3Zxxhm1ZH/PsYvdQkWnDumBOgaOMFvGawF03G0/mN3vuiNbBbunY5UJfSq9oj
 FydIAOv+bh48IUCx3V/1+F9ZlymuDf5nSSQJh3DqFbbKmRi1H+Td0ADG/OueCxcd5+qM
 aL+UybdpqVazelF9EqHcLy+CWexFuk90251jEiZKYmnxCMdhYjfJ+6fkLXlytx8JXgKW
 NMoQ==
X-Gm-Message-State: AOJu0Yxf7yBOaU4Mt4/v8mmQR1LPEUXXvYFZHDIVht1JvYOxxjiijLl6
 PUXODPv9Q0QrjB7A9VqxfJ3VspaDxFIdve1HFHTcfQRsn6pgUrWPNGsrbWppR+fCNrDCffTzPQ1
 vYdHctOySKQIMu/A3XE+SSnZ05+HnaAo=
X-Gm-Gg: ASbGncvW8ZMQ/Ey4PNsvB7Rw+RdOtMzCcdMgmNvrtcbGIlkk9MOX0SlYDZdl0r2431Y
 JumC8RPNAw5apcYm9yNo80d+mj+Kj9gLIheh67CKbNqW4lwwZAhTwLPYT4LimEKTVSREQeLrqZ0
 L0tFMwfrjpHKRMQ/aF3xXf4YePLK0IT/9PBEUuNBa3xFTY8CC9v6QIjAhsWT4f9jim0eLLQeFs9
 UYIpsvez81olBe83KGVNN7ZzaYPHMxAFkloR7GP2lZxt4Yk/cv9Ry09S7zm65ZiKaXi9Ao=
X-Google-Smtp-Source: AGHT+IEbbqJLfqvGbvwE6nI0D71PRHDbPjzvyZYH82+Srpr6rm1zH97MAOPHz8YOSRiULt04CYrhc7ApeK5Itye1zkA=
X-Received: by 2002:a05:6830:6112:b0:7b8:f2a2:46b8 with SMTP id
 46e09a7af769-7c6d142ea8cmr4766219a34.17.1762421665581; Thu, 06 Nov 2025
 01:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20251105120613.530-1-briansune@gmail.com>
 <20251105152144.GP6688@bill-the-cat>
In-Reply-To: <20251105152144.GP6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 6 Nov 2025 17:34:13 +0800
X-Gm-Features: AWmQ_bnvhLnh5ItuWhYFrut4LmvdHiTeeT-eZPeBN9_RRx8V9zdSI85awZGImyY
Message-ID: <CAN7C2SDuyY-yMOi=JD4R=jCUzGabcMLkyv_hYAjm_HR+ZEeECg@mail.gmail.com>
Subject: Re: [PATCH v1] sync doc/README.socfpga with new info
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> Right, so the first thing to do is migrate doc/README.socfpga to rST
> probably as doc/board/socfpga/index.rst (and include that in

Actually Tom, If you really need this documentation.
Thing will become very trouble and even difficult.
FPGA + SoC is a huge kind of SoC. Brand
involved Altera, Xilinx, Microsemi, Lattice.
All these big brand have FPSoC, and to document
all these is almost impossible. There are too many
brand and board.

Meantime, they all feel like they are not willing to
merge to mainstream U-Boot. Rather than pulling
from main stream and host its own vendor variant.

My goal is just trying to make  Altera GEN5 SoC
works on mainstream, as it is forgotten long long
time. And even some patch from Altera staff, breaks
the build and result in an unbootable build.

Brian
