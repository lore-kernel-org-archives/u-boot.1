Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20863C79FBB
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F1CF60B20;
	Thu, 10 Sep 2026 12:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YpSmgzPd-I08; Thu, 10 Sep 2026 12:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 74358608E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789042446;
	b=rSpJMWjoZQ0MS4XL577lkVocKyukEFnP3/e94ioG+i3ttOOrc2uSbtEB1D+6CxYssicQ
	 7jsf3Jn81SgdrkoykB553cuCtStOKS7IyDz3ilA+3aUyHmUriX3arUmS1gQeMvP4jng/f
	 HJmTYlzitfigoRijhX9UUE5GTNnHGnuEz5INNy6EFmJz3ORoEsC7zgJxsy+igzZ3KopG1
	 AvBfI/bXPFbvRK7lpUBpvEwIBfozsa3TjHHfeYc70cGDn+k/xHNCj5J0Z1k2YwaV2XI8N
	 5/4XH6asbRfBg1JaPCFcobvxVQDlfXzcNZzozwnqcgxCTmx2w0k/JdXbrXrBlp1BrtQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789042446;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GcXPbDKgJhv7Qg7j1sthn81A6y8F4t6lOGOUIOzJzSg=;
	b=SC7ZLWEEfhttVUtEotb7U0wBmdYv0tpKauRZr5E55lZVWYAMlZE2jfg8RXoAj3DMnEqQ
	 iLfG0A9XVLQkEdf38cRaOfPjxz95TOk2lFG7L4sHINlqc+IgdvkCQp7P9hnaIgJqgS9Of
	 FTmJUhKqS3Bbo2qepXSPqCbd98rFCXmo9kk6hE40TBACed2NomQYKyrviZVKAUO2ztRsm
	 1Y5ztu8qjEVcwokJAiXB71PUkyYEgsYfzi5D6zc9opuaXDBKMeHiLqMDqC7t4PleUIYSI
	 9oXDLTSVHcLncSXsyX1q5lJTSwh+4anNvaNnyosnjnpzPkij9cJrWIs1zrmycwL+Rfw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789042446;
	bh=GcXPbDKgJhv7Qg7j1sthn81A6y8F4t6lOGOUIOzJzSg=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BWfo4FdBumjhILKWaJeQzxN9vkulGmGV8SGfmYjL3Q/n9cgevlzIm0pNlNCQ1faBe
	 0xzG77z4leGAM3OL1DSz3r03C0yIOPAVmsVMLW1nPNJk3E3CR3bBbQ+1a44XFGAG+n
	 ZJSQz/3OsvS7JHNuPLPSH/hHS7LD2rZVdNlvLIrp1VSs59O2yvXsrGJ2JBBebujtZn
	 GmvqeqEAlcZfLGJenERGzPHcPggV2zZoIpVJDf9yNDuS9sgcQBNPdtoUJLQDf/k0pG
	 dVcqAIxPKs6eTjMm3HCwehYe6lIOu12GSdKb6P0PKuyPEhM+7D+vYV/SAMMLb/TW6h
	 CIH5u2oQfAYsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74358608E2;
	Thu, 10 Sep 2026 12:14:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 11783362
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0217280E86
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:48:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cownc13PyDSe for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 08:48:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B530C80E7C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789030101;
 b=XTev5l4FUCloofOxNr4xX8FLsBoBIGXwKXo1Ob487RR1DTrvwOVQ9FL28UG0N6BMtVlM
 lgzkiNsmhO6o+EKU0akyFe9C3RgVvNd5CpxXyYFXw8qHsOdkOB8T7ttULsKuKETJgWaQD
 7otaPRyHx4UDEAz5GbbRP1QWeBsLEwqSh9m7Jg4WpJ4WYd+nXe+UujvugwP6aWpIflI5n
 jA8qJ9YTbfZe1v1UdC8j8o4YUw7P/mcoe9pSjlPi/YTg/FVP6zPQK5OXqDkSmThgGywrO
 ui9nKwrJBz2nrJ8NCYyHRSJ4U8nPiOeiS86i33Jgg21dTAGmCZM9DspeASJj8XMzBYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789030101;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Content-Type;
 bh=GcXPbDKgJhv7Qg7j1sthn81A6y8F4t6lOGOUIOzJzSg=;
 b=K1+iSRn6cuEzjEOCWSGyiF7cdhLcgNBkebeMBBxog8h2/4N3RfrAj3fnhrmWtEN78PYc
 KzbOhDuxiWHdpVvWXzeIi6TtlyQMA2t0pBRx59J4ivkVlOZkBkrLB6E+EGhJGWeiYUYWO
 P0PVwWD96nPKU2Hm79P8qiGSoVuesZHYx5+kH6hW2omEGkekgQTcDigpwAVJaYCRRLQSi
 nytwaLduiinH9CQes2b9Q2PWApRDe9w1ElGEVQ6LF1GAqDN5VDaxy2wl6627nW88X8+pY
 Ze24KOGEemXoXgedXEs5nJMWOlLndAuzb7of46rRACC8zMWC45JMlKwC9fjP6VHAcrw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=tezduyar.com; 
 dkim=pass header.d=tezduyar-com.20251104.gappssmtp.com
 header.i=@tezduyar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WvXByCGp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=umut@tezduyar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=tezduyar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tezduyar-com.20251104.gappssmtp.com
 header.i=@tezduyar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WvXByCGp
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B530C80E7C
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:48:19 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2940ff2313so79312866b.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 01:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789030097; cv=none;
 d=google.com; s=arc-20260327;
 b=oKvUwi9xQBlz1qYthzbY540SXiddKbcNkR+yrF7HzWHzraN3CjN6Z7QDSeJJBS7YJ5
 GwWThuMbtA+FscWM7BeGSy4gH5/h2oeDbwHr8Jl4yj0I/uaC9xKbTcgWjVM9eHQ754QM
 U6LHStm2XIar2l2vJGXYShRGw6BXQMXU3RK09bD0s/o07DHaHA7iljvnTFtavfd0okC9
 7iwgnwncqBjYHxE0LegE7eIQ75gyY2ZFGzhFk+bDyleOTTPonn5WcH1Df/Zx2I2NMGf8
 AZ273rCvlu2ny5NvMepz8UjL3OpOb6nOvyBYEpRuogaB8SjVuKD8FnzvOODlPa+d8Rv2
 wAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=GcXPbDKgJhv7Qg7j1sthn81A6y8F4t6lOGOUIOzJzSg=;
 fh=UPNS4HXYeIypNL+s9tL6UKBnRLDlxVjvSkHwqhb8LsE=;
 b=Bs8vQLFaj9Kifcmt4yEOceNFQWl2rAirR+MUKT7sG7U0aB0+75JwsEZqs0sGua6Dlm
 xhm9zLUOOZF8rPPJFnwZYGH8yvLVLqZbVH5Zb90Hu7A6yf8q6+yN9BraVNVktlRAgxW7
 7P1UxwRjEvISCYyu/v4HsOcglct1ffglbiu3QmtaXYwNUxlcxoI6nIKMLoDhgBky3aBC
 1UyqDcQzE/+YudKxIlDit/GJkRVbI2jFJPq8KgKF8dWIG1V1ygttm5y8XJHjz5HSxNBo
 PAbo3OnHeVi/ro+KPyQFa5DK0l1pPCGrZ4Pq9jghiXhxGG1+Wu6CLnsdhVw5wm2HDTOp
 KQbQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tezduyar-com.20251104.gappssmtp.com; s=20251104; t=1789030097; x=1789634897;
 darn=lists.u-boot-project.org; 
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GcXPbDKgJhv7Qg7j1sthn81A6y8F4t6lOGOUIOzJzSg=;
 b=WvXByCGpW3g3TQo5+r8YNZ/i5QyUGnhvtgNEw/eTnIEVg0lXwq2Wxe0quCC4RY66NJ
 h12IHVQThsszCyGWTduIob/0NVYjePee5CA5yyDp1nulnj4G5lO6ak6/WbMECbLFjPEk
 /QO8pwfIsvkMM0pg+Pn0TNYtaW9JXOK0MGoa9DPVDP1ksOocTqTh/Shug8PLohDC8Izb
 IshGez3ud6rDuAK6fIMqvjny0usy4lOcKteyA2W9QsdL3bpMyk8q8R5JgvP1qsLsNExv
 qeJvlS//EwBaZonKVuiImDaWy6plfRpFQ1toNhLUKNFpc/39m1mvJ4ZJzzwX3/Xya087
 uY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789030097; x=1789634897;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GcXPbDKgJhv7Qg7j1sthn81A6y8F4t6lOGOUIOzJzSg=;
 b=j933yd87OwTOehW46c71eWqpWnR3y0y4qyudQKkByMXjZlizURZ9A+57K5GTs7fMlD
 BGo1TkLBL8Cx5hTzjoMjH+msQPtF/a+FPQs7+hsdZiFewaFh1g9LZg5xrRN1EBTTIp3o
 a1iiqURsqq8MQVSarqtiUo9XhXNroNwDByMRfVIve4eVHmI+ZQxLR0CTl1AIyvINC2W8
 Lawz9tU2W6FalhFrog5Ak/eH4xhXKuG3imda4k/dWzYo2cPOwlILZbyBhoeXsFJf6NFg
 BHgl269DfRjd6ncLp9dkbSVMwfFpJKBskAxHiSSWcJ9vfdVqJt4zxUL83Clo8uWlQJKy
 JvtQ==
X-Gm-Message-State: AFuF++nDjVZfjcoMVzHaGbDnxllgKs+0G7sw5Yx+MT9TnV+2JUfLlYQK
 f8h5oh+9Tk+wbyU7YvJOIzb2PHIJxamENPx4CYzteKiI2flSC2+MSAhwlMC1wlUyfjd1LpWYDPj
 1T0Qe+V7Z7Q0neI1P6dEixqwws8tpHHO4gYpTNNKvhEj7z9HUQc2biUZWRQ==
X-Gm-Gg: AYBFou0j82HVI1TNQTkt/ZlUR3Ri6mz3PsUGeSBmAVeme7kpuqFNKxYIhKsJ0DOxuHA
 m8vmXxXa2aYoS19Z1xmXgz54JrXiDxIYev0FPfjZDo7IbbOTGz9GN+DPa5nmpbwxpbV6gmYZkCO
 jRLXz6+ZZBxoxasMNfy3I+Yqc55Dt6Vcseysyb0YEVM08xLDlaUgROzkzZe2XNp268GC6QPV4ky
 pYcjq4ZLMZ842MyTFIPa8TfzFoEJXutnoPxajlStMoq2m5CA8Ggsm3RisC25/thCwb0/mvzoXOK
 2TkJXypDjg4u/0jghzjzqUy+yB5HzPAISm6ws9Yo7Nh+byO2zC2txY+vElYbtRL4fhbdwcZ4rvv
 cdoKZs/JVuw==
X-Received: by 2002:a17:907:6ea3:b0:c24:6382:2648 with SMTP id
 a640c23a62f3a-c2945dd4853mr191293066b.5.1789030096586; Thu, 10 Sep 2026
 01:48:16 -0700 (PDT)
MIME-Version: 1.0
From: Umut Tezduyar Lindskog <umut@tezduyar.com>
Date: Thu, 10 Sep 2026 10:47:50 +0200
X-Gm-Features: AcwNN1WnkZfByJr23laVaKnZ7Ka_j3QrPVV3GHCvOL2L-RRb-6iGCXH_n7PdOYk
Message-ID: <CAFKnvs4fEmyqAbNFobx1UR_KXhvrA_MqttNEpktrjNAH3vjv7w@mail.gmail.com>
Subject: Can u-boot UEFI provider implementation boot systemd-boot /
 systemd-stub?
To: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000666875065b1d073a"
X-Mailman-Approved-At: Thu, 10 Sep 2026 12:14:04 +0000
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

--000000000000666875065b1d073a
Content-Type: text/plain; charset="UTF-8"

Hello,

My understanding is that u-boot has its own limited UEFI provider
implementation unlike some other boot loaders bundling open source UEFI
payloads.

Has anyone tried to use u-boot's UEFI provider implementation on arm64 with
EFI applications systemd-boot and systemd-stub?

Using AI, I mapped all the API calls done by these programs to UEFI service
/ protocol. Most of the text input output functionality and graphics
functionality is irrelevant for my purposes.

ASCII text mapping table below:

systemd-boot

+----------------------------+------------------------------+-------------------------------+-------------------------------+--------------------------------------+

| UEFI service/protocol area | Sub-service or protocol      | Method
                | Dependency                    | Purpose
            |

+----------------------------+------------------------------+-------------------------------+-------------------------------+--------------------------------------+

| Boot Services              | Memory Allocation Services   | AllocatePool,
FreePool        | CORE                          | Manage general loader
data.          |

| Boot Services              | Protocol Handler Services    | HandleProtocol
              | CORE                          | Obtain required protocols.
        |

| Boot Services              | Image Services               | LoadImage
                | CORE                          | Load selected EFI image.
          |

| Boot Services              | Image Services               | StartImage
                | CORE                          | Start selected EFI image.
          |

| Boot Services              | Miscellaneous Boot Services  | CopyMem,
SetMem               | CORE                          | Perform basic memory
operations.     |

| Console Support Protocols  | Simple Text Output Protocol  | OutputString,
TestString      | CORE                          | Display text and test
glyphs.        |

| Console Support Protocols  | Simple Text Output Protocol  | QueryMode,
SetMode            | CORE                          | Query/select console
mode.           |

| Console Support Protocols  | Simple Text Output Protocol  | SetAttribute,
ClearScreen     | CORE                          | Format and redraw the
display.       |

| Console Support Protocols  | Simple Text Output Protocol  |
SetCursorPosition             | CORE                          | Position
menu text.                  |

| Console Support Protocols  | Simple Text Output Protocol  | EnableCursor,
Reset           | CORE                          | Initialize console
presentation.     |

| Media Access Protocols     | Simple File System Protocol  | OpenVolume
                | CORE                          | Open the ESP filesystem.
          |

| Media Access Protocols     | File Protocol                | Open, Read,
Close             | CORE                          | Read configuration and
EFI files.    |

| Media Access Protocols     | File Protocol                | GetInfo
                | CORE                          | Read file/directory
metadata.        |

| Device Path Protocols      | Device Path Protocol         | Data fields;
no method        | CORE                          | Construct path passed to
LoadImage.  |

| Loaded Image Protocols     | Loaded Image Protocol        | Data fields;
no method        | CORE                          | Obtain device, path and
image data.  |

+----------------------------+------------------------------+-------------------------------+-------------------------------+--------------------------------------+

| Boot Services              | Memory Allocation Services   |
AllocatePages, FreePages      | PATH (kernel/initrd/DT)       | Manage
aligned page allocations.     |

| Boot Services              | Protocol Handler Services    |
LocateDevicePath              | PATH (partition/initrd)       | Resolve
path to device handle.       |

| Boot Services              | Protocol Handler Services    |
LocateHandleBuffer            | PATH (device discovery)       | Enumerate
protocol providers.        |

| Boot Services              | Protocol Handler Services    | OpenProtocol
                | PATH (HTTP/network boot)      | Open network LoadFile
provider.      |

| Boot Services              | Protocol Handler Services    |
ConnectController             | PATH (driver/partition scan)  | Connect
drivers to controllers.      |

| Boot Services              | Image Services               | UnloadImage
                | PATH (failed image cleanup)   | Release an unsuccessfully
run image. |

| Boot Services              | Event/Timer/TPL Services     | CreateEvent,
CloseEvent       | PATH (interactive menu)       | Manage menu timeout
event.           |

| Boot Services              | Event/Timer/TPL Services     | SetTimer,
WaitForEvent        | PATH (interactive menu)       | Wait for timeout or
key input.       |

| Boot Services              | Event/Timer/TPL Services     | CheckEvent
                | PATH (interactive menu)       | Check whether input is
available.    |

| Boot Services              | Miscellaneous Boot Services  | Stall
                | PATH (delay/beep/error)       | Delay, beep or pause
before reboot.  |

| Boot Services              | Miscellaneous Boot Services  |
SetWatchdogTimer              | PATH (interactive menu)       | Manage
watchdog during input waits.  |

| Boot Services              | Miscellaneous Boot Services  | CalculateCrc32
              | PATH (GPT discovery)          | Validate GPT headers and
entries.    |

| Boot Services              | Miscellaneous Boot Services  |
InstallConfigurationTable     | PATH (DT/random-seed handoff) | Publish
data to the next image.      |

| Runtime Services           | Miscellaneous Runtime        | ResetSystem
                | PATH (reset/poweroff/setup)   | Perform requested system
reset.      |

|                            | Services                     |
                |                               |
            |

| Console Support Protocols  | Simple Text Input Protocol   | Reset,
ReadKeyStroke          | PATH (interactive menu)       | Process keyboard
input.              |

| Console Support Protocols  | Simple Text Input Protocol   | WaitForKey
                | PATH (interactive menu)       | Wait for keyboard input.
          |

| Media Access Protocols     | File Protocol                | SetPosition
                | PATH (offset/PE reads)        | Seek within a file.
            |

| Media Access Protocols     | Block I/O Protocol           | Media fields;
no method       | PATH (GPT/BitLocker)          | Inspect media geometry
and ID.       |

| Media Access Protocols     | Disk I/O Protocol            | ReadDisk
                | PATH (GPT/BitLocker)          | Read raw disk metadata.
            |

| Media Access Protocols     | Load File Protocol           | LoadFile
                | PATH (HTTP/network boot)      | Load a network boot
entry.           |

+----------------------------+------------------------------+-------------------------------+-------------------------------+--------------------------------------+

| Boot Services              | Protocol Handler Services    | LocateProtocol
              | OPTIONAL                      | Discover optional
interfaces.        |

| Boot Services              | Miscellaneous Boot Services  |
GetNextMonotonicCount         | OPTIONAL                      | Add input
to random-seed evolution.  |

| Runtime Services           | Variable Services            | GetVariable
                | OPTIONAL                      | Read configuration and
state.        |

| Runtime Services           | Variable Services            | SetVariable
                | OPTIONAL                      | Persist selection and
state.         |

| Runtime Services           | Time Services                | GetTime
                | OPTIONAL                      | Add input to random-seed
evolution.  |

| Console Support Protocols  | Simple Text Input Ex Protocol|
ReadKeyStrokeEx               | OPTIONAL                      | Read richer
key information.         |

| Console Support Protocols  | Graphics Output Protocol     | Blt
                | OPTIONAL                      | Draw graphical splash.
            |

| Console Support Protocols  | EDID Discovered Protocol     | Data fields;
no method        | OPTIONAL                      | Inspect display
identification.      |

| Media Access Protocols     | File Protocol                | Write, Flush,
SetInfo         | OPTIONAL                      | Save seed, secret and
counters.      |

| Device Path Protocols      | Device Path To Text Protocol |
ConvertDevicePathToText       | OPTIONAL                      | Format
paths for diagnostics.        |

| PCI Bus Support Protocols  | PCI I/O Protocol             | Pci.Read
                | OPTIONAL                      | Detect VirtIO console
hardware.      |

| HII Protocols              | HII Database Protocol        |
GetKeyboardLayout             | OPTIONAL                      | Discover
firmware keyboard layout.  |

| RNG Protocols              | RNG Protocol                 | GetRNG
                | OPTIONAL                      | Obtain entropy.
            |

| Memory Attribute Protocols | Memory Attribute Protocol    |
SetMemoryAttributes           | OPTIONAL                      | Apply
read-only/NX protection.       |

| Memory Attribute Protocols | Memory Attribute Protocol    |
ClearMemoryAttributes         | OPTIONAL                      | Remove
conflicting attributes.      |

| TCG EFI Protocols          | TCG2 Protocol                | GetCapability
              | OPTIONAL                      | Discover TPM capabilities.
        |

| TCG EFI Protocols          | TCG2 Protocol                |
HashLogExtendEvent            | OPTIONAL                      | Measure
boot data into PCRs.         |

| TCG EFI Protocols          | CC Measurement Protocol      | GetCapability
              | OPTIONAL                      | Discover CC measurement
support.     |

| TCG EFI Protocols          | CC Measurement Protocol      |
MapPcrToMrIndex               | OPTIONAL                      | Map PCRs to
CC registers.            |

| TCG EFI Protocols          | CC Measurement Protocol      |
HashLogExtendEvent            | OPTIONAL                      | Measure
data into CC registers.      |

| PI Architectural Protocols | Security Arch Protocol       |
FileAuthenticationState hook  | OPTIONAL                      | Support
validation with old shim.    |

| PI Architectural Protocols | Security2 Arch Protocol      |
FileAuthentication hook       | OPTIONAL                      | Support
validation with old shim.    |

| Platform Extensions        | Console Control Protocol     | GetMode,
SetMode              | OPTIONAL                      | Switch text/graphics
mode.           |

| Platform Extensions        | Device Tree Fixup Protocol   | Fixup
                | OPTIONAL                      | Let firmware adjust a
device tree.   |

| Shim Vendor Protocols      | Shim Lock Protocol           | shim_verify
                | OPTIONAL                      | Verify image with older
shim.        |

+----------------------------+------------------------------+-------------------------------+-------------------------------+--------------------------------------+

| Boot Services              | Protocol Handler Services    |
InstallMultipleProtocol-      | PROVIDED                      | Publish
systemd's initrd protocols.  |

|                            |                              | Interfaces
                |                               |
            |

| Boot Services              | Protocol Handler Services    |
UninstallMultipleProtocol-    | PROVIDED                      | Remove
systemd's initrd protocols.   |

|                            |                              | Interfaces
                |                               |
            |

| Media Access Protocols     | Load File 2 Protocol         | LoadFile
                | PROVIDED                      | Serve initrd data to
Linux.          |

+----------------------------+------------------------------+-------------------------------+-------------------------------+--------------------------------------+

systemd-stub

+----------------------------+------------------------------+-------------------------------+--------------------------------+--------------------------------------+

| UEFI service/protocol area | Sub-service or protocol      | Method
                | Dependency                     | Purpose
            |

+----------------------------+------------------------------+-------------------------------+--------------------------------+--------------------------------------+

| Boot Services              | Memory Allocation Services   | AllocatePool,
FreePool        | CORE                           | Allocate UKI processing
data.        |

| Boot Services              | Protocol Handler Services    | HandleProtocol
              | CORE                           | Obtain Loaded Image
protocol.        |

| Boot Services              | Miscellaneous Boot Services  | CopyMem,
SetMem               | CORE                           | Copy and initialize
payload data.    |

| Loaded Image Protocols     | Loaded Image Protocol        | Data fields;
no method        | CORE                           | Locate PE sections and
load options. |

+----------------------------+------------------------------+-------------------------------+--------------------------------+--------------------------------------+

| Boot Services              | Memory Allocation Services   |
AllocatePages, FreePages      | PATH (direct kernel loader)    | Allocate
memory for inner kernel.    |

| Boot Services              | Image Services               | LoadImage
                | PATH (shim/firmware loader)    | Load inner kernel
through firmware.  |

| Boot Services              | Image Services               | StartImage
                | PATH (shim/firmware loader)    | Start firmware-loaded
inner kernel.  |

| Boot Services              | Image Services               | UnloadImage
                | PATH (shim loader cleanup)     | Clean up failed inner
image.         |

| Boot Services              | Miscellaneous Boot Services  |
InstallConfigurationTable     | PATH (device-tree handoff)     | Install
embedded/addon device tree.  |

| Device Path Protocols      | Device Path Protocol         | Data fields;
no method        | PATH (kernel/initrd handoff)   | Describe inner
kernel/initrd path.   |

+----------------------------+------------------------------+-------------------------------+--------------------------------+--------------------------------------+

| Boot Services              | Protocol Handler Services    | LocateProtocol
              | OPTIONAL                       | Find optional firmware
protocols.    |

| Boot Services              | Protocol Handler Services    |
LocateDevicePath              | OPTIONAL                       | Find a
previously supplied initrd.   |

| Boot Services              | Miscellaneous Boot Services  |
GetNextMonotonicCount         | OPTIONAL                       | Add input
to random-seed update.     |

| Runtime Services           | Variable Services            | GetVariable
                | OPTIONAL                       | Read Secure Boot and
boot state.     |

| Runtime Services           | Variable Services            | SetVariable
                | OPTIONAL                       | Export state and update
seed data.   |

| Runtime Services           | Time Services                | GetTime
                | OPTIONAL                       | Add input to random-seed
update.     |

| Console Support Protocols  | Simple Text Output Protocol  | OutputString,
SetAttribute    | OPTIONAL                       | Display diagnostics.
            |

| Console Support Protocols  | Graphics Output Protocol     | Blt
                | OPTIONAL                       | Draw embedded splash.
            |

| Media Access Protocols     | Simple File System Protocol  | OpenVolume
                | OPTIONAL                       | Open filesystem for
sidecars.        |

| Media Access Protocols     | File Protocol                | Open, Read,
Close             | OPTIONAL                       | Read addons and
sidecars.            |

| Media Access Protocols     | File Protocol                | GetInfo,
SetPosition          | OPTIONAL                       | Inspect and seek
within files.       |

| UEFI Shell Protocols       | Shell Parameters Protocol    | Data fields;
no method        | OPTIONAL                       | Obtain shell-provided
arguments.     |

| RNG Protocols              | RNG Protocol                 | GetRNG
                | OPTIONAL                       | Obtain entropy and
refresh seed.     |

| Memory Attribute Protocols | Memory Attribute Protocol    |
SetMemoryAttributes           | OPTIONAL                       | Mark
loaded sections read-only/NX.   |

| Memory Attribute Protocols | Memory Attribute Protocol    |
ClearMemoryAttributes         | OPTIONAL                       | Permit
required executable access.  |

| TCG EFI Protocols          | TCG2 Protocol                | GetCapability
              | OPTIONAL                       | Discover TPM capabilities.
        |

| TCG EFI Protocols          | TCG2 Protocol                |
HashLogExtendEvent            | OPTIONAL                       | Measure
UKI data into PCRs.           |

| TCG EFI Protocols          | CC Measurement Protocol      | GetCapability
              | OPTIONAL                       | Discover CC measurement
support.     |

| TCG EFI Protocols          | CC Measurement Protocol      |
MapPcrToMrIndex               | OPTIONAL                       | Map PCRs
to CC registers.            |

| TCG EFI Protocols          | CC Measurement Protocol      |
HashLogExtendEvent            | OPTIONAL                       | Measure
UKI data into CC registers.  |

| PI Architectural Protocols | Security Arch Protocol       |
FileAuthenticationState hook  | OPTIONAL                       | Support
validation with old shim.    |

| PI Architectural Protocols | Security2 Arch Protocol      |
FileAuthentication hook       | OPTIONAL                       | Support
validation with old shim.    |

| Platform Extensions        | Console Control Protocol     | GetMode,
SetMode              | OPTIONAL                       | Switch mode for
splash display.      |

| Platform Extensions        | Device Tree Fixup Protocol   | Fixup
                | OPTIONAL                       | Let firmware adjust
embedded DT.     |

| Shim Vendor Protocols      | Shim Lock Protocol           | shim_verify
                | OPTIONAL                       | Verify inner image with
older shim.  |

+----------------------------+------------------------------+-------------------------------+--------------------------------+--------------------------------------+

| Boot Services              | Protocol Handler Services    |
InstallMultipleProtocol-      | PROVIDED                       | Publish
assembled initrd protocol.   |

|                            |                              | Interfaces
                |                                |
            |

| Boot Services              | Protocol Handler Services    |
UninstallMultipleProtocol-    | PROVIDED                       | Remove
assembled-initrd handle.      |

|                            |                              | Interfaces
                |                                |
            |

| Media Access Protocols     | Load File 2 Protocol         | LoadFile
                | PROVIDED                       | Serve assembled initrd
to Linux.     |

+----------------------------+------------------------------+-------------------------------+--------------------------------+--------------------------------------+

--000000000000666875065b1d073a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"monospace">Hello,=C2=A0</font><div><font fac=
e=3D"monospace"><br></font></div><div><font face=3D"monospace">My understan=
ding is that u-boot has its own limited UEFI provider implementation unlike=
 some other boot loaders bundling open source UEFI payloads.=C2=A0</font></=
div><div><font face=3D"monospace"><br></font></div><div><font face=3D"monos=
pace">Has anyone tried to use u-boot&#39;s=C2=A0UEFI provider implementatio=
n on arm64 with EFI applications systemd-boot and systemd-stub?<br></font><=
/div><div><font face=3D"monospace"><br></font></div><div><font face=3D"mono=
space">Using AI, I mapped all the API calls done by these programs to UEFI =
service / protocol. Most of the text input output functionality and graphic=
s functionality is irrelevant for my purposes.=C2=A0</font></div><div><font=
 face=3D"monospace"><br></font></div><div><font face=3D"monospace">ASCII te=
xt mapping table below:=C2=A0</font></div><div><font face=3D"monospace"><br=
></font></div><div><p style=3D"margin:0px;font-size:13px;line-height:normal=
;font-size-adjust:none;font-kerning:auto;font-variant-alternates:normal;fon=
t-variant-ligatures:normal;font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-feature-settings:normal"><font face=3D"monospace">systemd-b=
oot</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
---------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| UEFI service/protocol area=
 | Sub-service or protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| Method<span class=3D"gmail-Apple-converted-space=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>| Dependency<span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Purpose<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
---------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Memory Allocation Services <span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| AllocatePool, FreePool<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"=
gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Manage general loade=
r data.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| HandleProtocol<span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </s=
pan>| CORE<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Obtain required protocols. <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Image Services <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| LoadImage <span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Load selected EFI image. <span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Image Services <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| StartImage<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Start selected EFI image.<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| CopyMem, SetMem <span class=3D"gmail-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE=
<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Perfor=
m basic memory operations. <span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Outp=
ut Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Outp=
utString, TestString<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>| CORE<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>| Display text and test glyphs.<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Outp=
ut Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Quer=
yMode, SetMode<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"gmail-Apple-converted-=
space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Query/select console mode. <span class=3D=
"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</=
font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Outp=
ut Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| SetA=
ttribute, ClearScreen <span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 </span>| CORE<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Format and redraw the display. <span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Outp=
ut Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| SetC=
ursorPosition <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"gmail-Apple-converted-=
space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Position menu text.<span class=3D"gmail-A=
pple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Outp=
ut Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Enab=
leCursor, Reset <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"gmail-Apple-converted-spac=
e">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| Initialize console presentation. <span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Simple File=
 System Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|=
 OpenVolume<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Open the ESP file=
system. <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| File Protoc=
ol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Open, Read, Close <span class=3D"gmail=
-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| =
CORE<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Re=
ad configuration and EFI files.<span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| File Protoc=
ol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetInfo <span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>| Read file/directory metadata.<span class=3D"gmai=
l-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Device Path Protocols<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| Device=
 Path Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>| Data fields; no method<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"gmail=
-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Construct path passed to=
 LoadImage.<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</fon=
t></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Loaded Image Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Loaded Imag=
e Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Data fields; no method<span class=3D"gmail-Apple-converted-=
space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE<span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Obtain device, path and image d=
ata.<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
---------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Memory Allocation Services <span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| AllocatePages, FreePages<span class=3D"gmail-Ap=
ple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| PATH (kernel/initrd/DT) =
<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| M=
anage aligned page allocations. <span class=3D"gmail-Apple-converted-space"=
>=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| LocateDevicePath<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|=
 PATH (partition/initrd) <span class=3D"gmail-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 </span>| Resolve path to device handle. <span class=3D"gmail=
-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| LocateHandleBuffer<span class=3D"gmail-App=
le-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH=
 (device discovery) <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>| Enumerate protocol providers.<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| OpenProtocol<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>| PATH (HTTP/network boot)<span class=3D"gmail-Apple-converted-s=
pace">=C2=A0 =C2=A0 =C2=A0 </span>| Open network LoadFile provider.<span cl=
ass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p=
>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| ConnectController <span class=3D"gmail-App=
le-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH=
 (driver/partition scan)<span class=3D"gmail-Apple-converted-space">=C2=A0 =
</span>| Connect drivers to controllers.<span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Image Services <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| UnloadImage <span=
 class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH (failed image cleanup) <span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 </span>| Release an unsuccessfully=
 run image. |</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Event/Timer/TPL Services <span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| CreateEvent, CloseEvent <span class=3D"gma=
il-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| PATH (interactive m=
enu) <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </spa=
n>| Manage menu timeout event. <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Event/Timer/TPL Services <span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| SetTimer, WaitForEvent<span class=3D"gmail=
-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH (interact=
ive menu) <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
</span>| Wait for timeout or key input. <span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Event/Timer/TPL Services <span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| CheckEvent<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| PATH (interactive menu) <span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 </span>| Check whether input is available.<sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| Stall <span class=3D"gmail-Apple-converted-spac=
e">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>| PATH (delay/beep/error) <span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 </span>| Delay, beep or pause before r=
eboot.<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font></p=
>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| SetWatchdogTimer<span class=3D"gmail-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH=
 (interactive menu) <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 </span>| Manage watchdog during input waits.<span class=3D"gmail=
-Apple-converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| CalculateCrc32<span class=3D"gmail-Apple-conver=
ted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|=
 PATH (GPT discovery)<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Validate GPT headers and entries.<span cl=
ass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| InstallConfigurationTable <span class=3D"gmail-=
Apple-converted-space">=C2=A0 =C2=A0 </span>| PATH (DT/random-seed handoff)=
 | Publish data to the next image.<span class=3D"gmail-Apple-converted-spac=
e">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Runtime Services <span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Miscellaneous Runtime<span class=3D"gmail-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 </span>| ResetSystem <span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
</span>| PATH (reset/poweroff/setup) <span class=3D"gmail-Apple-converted-s=
pace">=C2=A0 </span>| Perform requested system reset.<span class=3D"gmail-A=
pple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">|<span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Services <span class=3D"=
gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 </span>| <span class=3D"gmail-Apple-converted-spac=
e">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| <span class=3D"gmail-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-App=
le-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Inpu=
t Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Rese=
t, ReadKeyStroke<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| PATH (interactive menu) <span class=3D"gmail-=
Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| Process keyboard input=
.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Inpu=
t Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Wait=
ForKey<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH (interactive me=
nu) <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>| Wait for keyboard input. <span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| File Protoc=
ol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| SetPosition <span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| PATH (offset/PE reads)<span class=3D"gmail-Apple-converted-=
space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Seek within a file.<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Block I/O P=
rotocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>| Media fields; no method <span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 </span>| PATH (GPT/BitLocker)<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Inspect media geometry and ID. <span class=3D"gmail-Apple-converted-spa=
ce">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Disk I/O Pr=
otocol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>| ReadDisk<span class=3D"gmail-Apple-converted-spa=
ce">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| PATH (GPT/BitLocker)<span class=3D"gmail-Apple-converted-sp=
ace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Read raw disk metadata.<sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Load File P=
rotocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>| LoadFile<span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>| PATH (HTTP/network boot)<span class=3D"gmail-Apple-converted-s=
pace">=C2=A0 =C2=A0 =C2=A0 </span>| Load a network boot entry. <span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>=
|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
---------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| LocateProtocol<span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </s=
pan>| OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Discov=
er optional interfaces.<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| GetNextMonotonicCount <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Add input to random-seed evolut=
ion.<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Runtime Services <span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Variable Services<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetVariable <span class=3D"gmail-A=
pple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>| OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>| Read configuration and state.<span class=3D"gmail-Apple-converted-s=
pace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Runtime Services <span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Variable Services<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| SetVariable <span class=3D"gmail-A=
pple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>| OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>| Persist selection and state. <span class=3D"gmail-Apple-converted-s=
pace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Runtime Services <span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Time Services<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetTime <span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| Add input to random-seed evolution.<span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Inpu=
t Ex Protocol| ReadKeyStrokeEx <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Read richer key information=
. <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Graphics Output =
Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|=
 Blt <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|=
 OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Draw graph=
ical splash. <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| EDID Discovered =
Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|=
 Data fields; no method<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span class=3D"gmail-Apple-converted-=
space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>| Inspect display identification.<span class=3D"gmail-App=
le-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| File Protoc=
ol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Write, Flush, SetInfo <span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<s=
pan class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Save seed, secret an=
d counters.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Device Path Protocols<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| Device=
 Path To Text Protocol | ConvertDevicePathToText <span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span class=3D"gmai=
l-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Format paths for diagnostics.<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</fo=
nt></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| PCI Bus Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| PCI I/O Protocol=
 <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>| Pci.Read<span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>| OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|=
 Detect VirtIO console hardware.<span class=3D"gmail-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| HII Protocols<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| HII Database Protocol<span class=3D"gmail-Apple-converted-s=
pace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetKeyboardLayout <span class=3D=
"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </s=
pan>| OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Discov=
er firmware keyboard layout.<span class=3D"gmail-Apple-converted-space">=C2=
=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| RNG Protocols<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| RNG Protocol <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetRNG<spa=
n class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Obtain entropy.<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Memory Attribute Protocols=
 | Memory Attribute Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 </span>| SetMemoryAttributes <span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span class=3D=
"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Apply read-only/NX protection. <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>|</fon=
t></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Memory Attribute Protocols=
 | Memory Attribute Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 </span>| ClearMemoryAttributes <span class=3D"gmail-Apple-conver=
ted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span class=3D"gmai=
l-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Remove conflicting attributes.<span cl=
ass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>|</font></p=
>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| TCG2 Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetCapability <span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 </span>| OPTIONAL<span class=3D"gmail-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>| Discover TPM capabilities. <span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| TCG2 Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| HashLogExtendEvent<span =
class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Measure boot data into PCRs. <span class=3D"gmail-Apple-converted-space=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| CC Measurement Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| GetCapability <span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| =
OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Discover C=
C measurement support. <span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| CC Measurement Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| MapPcrToMrIndex <span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIO=
NAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Map PCRs to CC re=
gisters.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| CC Measurement Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| HashLogExtendEvent<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<s=
pan class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Measure data into CC=
 registers.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| PI Architectural Protocols=
 | Security Arch Protocol <span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| FileAuthenticationState hook<span class=3D"gmail=
-Apple-converted-space">=C2=A0 </span>| OPTIONAL<span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| Support validation with old shim.<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| PI Architectural Protocols=
 | Security2 Arch Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| FileAuthentication hook <span class=3D"gmail-App=
le-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span class=3D"gm=
ail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Support validation with old shim.<spa=
n class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Platform Extensions<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| C=
onsole Control Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 </span>| GetMode, SetMode<span class=3D"gmail-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL<span cl=
ass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Switch text/graphics mode. =
<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Platform Extensions<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| D=
evice Tree Fixup Protocol <span class=3D"gmail-Apple-converted-space">=C2=
=A0 </span>| Fixup <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>| OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Let=
 firmware adjust a device tree. <span class=3D"gmail-Apple-converted-space"=
>=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Shim Vendor Protocols<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| Shim L=
ock Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>| shim_verify <span class=3D"gmail-Apple-converted=
-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </sp=
an>| OPTIONAL<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Verify=
 image with older shim.<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
---------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| InstallMultipleProtocol-<span class=3D"gma=
il-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| PROVIDED<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Publish systemd&#39;s initrd pr=
otocols.<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font><=
/p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">|<span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Interfaces<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| <span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| UninstallMultipleProtocol-<span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 </span>| PROVIDED<span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Remove systemd&#39;s initrd protoc=
ols. <span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">|<span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Interfaces<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| <span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Load File 2=
 Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| LoadFile<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| PROVIDED<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Serve =
initrd data to Linux.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
---------------------+--------------------------------------+<span style=3D=
"line-height:normal;font-size-adjust:none;font-kerning:auto;font-variant-al=
ternates:normal;font-variant-ligatures:normal;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;font-feature-settings:normal"><br>
</span></font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">systemd-stub</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
----------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| UEFI service/protocol area=
 | Sub-service or protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| Method<span class=3D"gmail-Apple-converted-space=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>| Dependency <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Purpose<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
----------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Memory Allocation Services <span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| AllocatePool, FreePool<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE <span class=3D=
"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Allocate UKI process=
ing data.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| HandleProtocol<span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </s=
pan>| CORE <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </sp=
an>| Obtain Loaded Image protocol.<span class=3D"gmail-Apple-converted-spac=
e">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| CopyMem, SetMem <span class=3D"gmail-Apple-conv=
erted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE=
 <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Cop=
y and initialize payload data.<span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Loaded Image Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Loaded Imag=
e Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Data fields; no method<span class=3D"gmail-Apple-converted-=
space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| CORE <span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Locate PE sections and load opt=
ions. |</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
----------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Memory Allocation Services <span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| AllocatePages, FreePages<span class=3D"gmail-Ap=
ple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| PATH (direct kernel load=
er)<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Alloc=
ate memory for inner kernel.<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Image Services <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| LoadImage <span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH (shim/firmware loader)<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Load inner kern=
el through firmware.<span class=3D"gmail-Apple-converted-space">=C2=A0 </sp=
an>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Image Services <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| StartImage<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH (shim/firmware loader)<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Start firmware-=
loaded inner kernel.<span class=3D"gmail-Apple-converted-space">=C2=A0 </sp=
an>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Image Services <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| UnloadImage <span=
 class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH (shim loader cleanup) <span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Clean up failed inn=
er image. <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| InstallConfigurationTable <span class=3D"gmail-=
Apple-converted-space">=C2=A0 =C2=A0 </span>| PATH (device-tree handoff) <s=
pan class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Install em=
bedded/addon device tree.<span class=3D"gmail-Apple-converted-space">=C2=A0=
 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Device Path Protocols<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| Device=
 Path Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 </span>| Data fields; no method<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| PATH (kernel/initrd hand=
off) <span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Describe i=
nner kernel/initrd path. <span class=3D"gmail-Apple-converted-space">=C2=A0=
 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
----------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| LocateProtocol<span class=3D"gmail-Apple-c=
onverted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </s=
pan>| OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Fin=
d optional firmware protocols.<span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| LocateDevicePath<span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|=
 OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Find a pre=
viously supplied initrd. <span class=3D"gmail-Apple-converted-space">=C2=A0=
 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Miscellaneous Boot Services<span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 </span>| GetNextMonotonicCount <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Add input to random-seed updat=
e. <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font=
></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Runtime Services <span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Variable Services<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetVariable <span class=3D"gmail-A=
pple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>| OPTIONAL <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>| Read Secure Boot and boot state. <span class=3D"gmail-Apple-co=
nverted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Runtime Services <span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Variable Services<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| SetVariable <span class=3D"gmail-A=
pple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 </span>| OPTIONAL <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>| Export state and update seed data. <span class=3D"gmail-Apple-=
converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Runtime Services <span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| Time Services<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetTime <span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| Add input to random-seed update. <span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Simple Text Outp=
ut Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Outp=
utString, SetAttribute<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 </span>| OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </sp=
an>| Display diagnostics. <span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Console Support Protocols<=
span class=3D"gmail-Apple-converted-space">=C2=A0 </span>| Graphics Output =
Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|=
 Blt <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|=
 OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Draw embed=
ded splash.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Simple File=
 System Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|=
 OpenVolume<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Open filesystem for sidecar=
s.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| File Protoc=
ol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Open, Read, Close <span class=3D"gmail=
-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| =
OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Read addon=
s and sidecars.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| File Protoc=
ol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetInfo, SetPosition<span class=3D"gma=
il-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIO=
NAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Inspect and seek=
 within files. <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| UEFI Shell Protocols <span=
 class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| Shell =
Parameters Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 </span>| Data fields; no method<span class=3D"gmail-Apple-converted-spa=
ce">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| Obtain shell-provided arguments. <span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| RNG Protocols<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| RNG Protocol <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetRNG<spa=
n class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span cl=
ass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Obtain entropy and refresh =
seed. <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</f=
ont></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Memory Attribute Protocols=
 | Memory Attribute Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 </span>| SetMemoryAttributes <span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Mark loaded sections read-only/=
NX. <span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Memory Attribute Protocols=
 | Memory Attribute Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 </span>| ClearMemoryAttributes <span class=3D"gmail-Apple-conver=
ted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span class=3D"gma=
il-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Permit required executable access.<spa=
n class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| TCG2 Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| GetCapability <span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 </span>| OPTIONAL <span class=3D"gmail-Apple-converted-space=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 </span>| Discover TPM capabilities. <span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| TCG2 Protocol<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| HashLogExtendEvent<span =
class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </sp=
an>| Measure UKI data into PCRs. <span class=3D"gmail-Apple-converted-space=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| CC Measurement Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| GetCapability <span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| =
OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Discover C=
C measurement support. <span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| CC Measurement Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| MapPcrToMrIndex <span class=3D"gmail-Apple-conve=
rted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIO=
NAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Map PCRs to CC r=
egisters.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| TCG EFI Protocols<span cla=
ss=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| CC Measurement Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| HashLogExtendEvent<span class=3D"gmail-Apple-con=
verted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <=
span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Measure UKI data int=
o CC registers.<span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|<=
/font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| PI Architectural Protocols=
 | Security Arch Protocol <span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| FileAuthenticationState hook<span class=3D"gmail=
-Apple-converted-space">=C2=A0 </span>| OPTIONAL <span class=3D"gmail-Apple=
-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>| Support validation with old shim.<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| PI Architectural Protocols=
 | Security2 Arch Protocol<span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 =C2=A0 </span>| FileAuthentication hook <span class=3D"gmail-App=
le-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Support validation with old shim.<=
span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>|</font></p=
>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Platform Extensions<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| C=
onsole Control Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 </span>| GetMode, SetMode<span class=3D"gmail-Apple-converted-space"=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| OPTIONAL <span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Switch mode for splash disp=
lay.<span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span=
>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Platform Extensions<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| D=
evice Tree Fixup Protocol <span class=3D"gmail-Apple-converted-space">=C2=
=A0 </span>| Fixup <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <=
/span>| OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Let=
 firmware adjust embedded DT. <span class=3D"gmail-Apple-converted-space">=
=C2=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Shim Vendor Protocols<span=
 class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| Shim L=
ock Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 </span>| shim_verify <span class=3D"gmail-Apple-converted=
-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </sp=
an>| OPTIONAL <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Verify=
 inner image with older shim.<span class=3D"gmail-Apple-converted-space">=
=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
----------------------+--------------------------------------+</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| InstallMultipleProtocol-<span class=3D"gma=
il-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>| PROVIDED <span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Publish assembled initrd proto=
col. <span class=3D"gmail-Apple-converted-space">=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">|<span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Interfaces<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-=
Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Boot Services<span class=
=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| Protocol Handler Services<span class=3D"gmail-Apple-convert=
ed-space">=C2=A0 =C2=A0 </span>| UninstallMultipleProtocol-<span class=3D"g=
mail-Apple-converted-space">=C2=A0 =C2=A0 </span>| PROVIDED <span class=3D"=
gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Remove assembled-initrd handle.<sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 </span>|</fon=
t></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">|<span class=3D"gmail-Apple-=
converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-Appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Interfaces<span c=
lass=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-Apple-converte=
d-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>|<span class=3D"gmail-=
Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">| Media Access Protocols <sp=
an class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>| Load File 2=
 Protocol <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 </span>| LoadFile<span class=3D"gmail-Apple-converted-space">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </spa=
n>| PROVIDED <span class=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>| Serve =
assembled initrd to Linux. <span class=3D"gmail-Apple-converted-space">=C2=
=A0 =C2=A0 </span>|</font></p>
<p style=3D"margin:0px;font-size:13px;line-height:normal;font-size-adjust:n=
one;font-kerning:auto;font-variant-alternates:normal;font-variant-ligatures=
:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-fea=
ture-settings:normal"><font face=3D"monospace">+---------------------------=
-+------------------------------+-------------------------------+----------=
----------------------+--------------------------------------+</font></p></=
div></div>

--000000000000666875065b1d073a--
