Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6454BE6BF2F
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 18:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC34E84543;
	Fri, 30 Jan 2026 19:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=artiphishell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=artiphishell.com header.i=jay@artiphishell.com header.b="gALK13cg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7732284535; Fri, 30 Jan 2026 19:05:40 +0100 (CET)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59418452D
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 19:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=artiphishell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jay@artiphishell.com
ARC-Seal: i=1; a=rsa-sha256; t=1769796334; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dkFzGHcxss3a6x0BfMYD2NLsvv1dp1nyUkP/xDa7IzUfAxRLtknxpHqScOlqV622gOmUXCLQsyAP13An8QQ8Qd8D25shPNiIVZ/QAk7MFukHfyx6vedmKqb7Eq5f7oErb7i1qFiqao0O7IgmQ7eR2TRmAw4nFUKLPZ/k6H8TBhg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1769796334;
 h=Content-Type:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=tsevCh8I9wY4JtRfzWB/AB5Fm5gMEKXfuC2Do7oJh5g=; 
 b=fe8s7aECmC1yJUUnTXvjG5mgJxAr3hADcG37aHi8i9ZsFngHjd0Ho/xGkNgg8X5GDfHXiRazeB1P6fokqZASeiWTmCSyiY26yuSgev8yEZt/ewkl5mlTzulJgCBoRCez9ULb9bSTW9zXMFzuCgyKnr+9D5pp5rnwVLLuq43GpMg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=artiphishell.com;
 spf=pass  smtp.mailfrom=jay@artiphishell.com;
 dmarc=pass header.from=<jay@artiphishell.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769796334; 
 s=artiphishell; d=artiphishell.com; i=jay@artiphishell.com;
 h=Date:Date:From:From:To:To:Message-Id:Message-Id:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Reply-To:Cc;
 bh=tsevCh8I9wY4JtRfzWB/AB5Fm5gMEKXfuC2Do7oJh5g=;
 b=gALK13cgZduyKW5nwxz/94VhO/8b6xR3tlOb8IkK8gYplTyB8VFxorqz60yq3svP
 iMJgC5SSKJKwFl504ex/gdb4HHkrWKQOMtGqd7vwd2/oGZBXV5s30O8Cq6cIYcyNTzk
 sVPc/KbyV8Yq/60M8b7FNrnfXCYjDFautzAsfq4Y=
Received: from mail.zoho.com by mx.zohomail.com
 with SMTP id 176979633229993.74582390834496;
 Fri, 30 Jan 2026 10:05:32 -0800 (PST)
Date: Fri, 30 Jan 2026 11:05:32 -0700
From: Jayakrishna Menon Vadayath <jay@artiphishell.com>
To: "u-boot" <u-boot@lists.denx.de>
Message-Id: <19c1014eab6.1532d2031010885.3850895763268977901@artiphishell.com>
In-Reply-To: 
Subject: Unchecked IPv6 payload length leads to Out-of-Bounds read in
 net_ip6_handler
MIME-Version: 1.0
Content-Type: multipart/mixed; 
 boundary="----=_Part_3503394_1198268125.1769796332215"
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/269.789.21
X-Mailman-Approved-At: Fri, 30 Jan 2026 19:31:22 +0100
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

------=_Part_3503394_1198268125.1769796332215
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear maintainers,



We have found an issue in u-boot that can lead to an Out-of-Bounds error wh=
en compiled with ASAN.

The details of the issue are as follows:


Issue Description:

Crash reproduced by `poc.sh` feeds a crafted IPv6 packet with a incorrect p=
ayload length into the `net_process_received_packet @ net/net.c`.



Vulnerable path:

=C2=A0 =C2=A0 =C2=A0- `net_process_received_packet` -> `net_ip6_handler` ->=
 `csum_partial` -> `csum_do_csum`



Root cause:
`net_ip6_handler()` trusts the IPv6 `payload_len` and computes checksums ov=
er `hlen =3D ntohs(ip6->payload_len)` without verifying that the incoming f=
rame contains that many bytes.

With a truncated frame and a large `payload_len`, `csum_partial()` reads pa=
st the end of the RX buffer, causing a buffer overflow that is caught by AS=
AN.



Modifications to u-boot

In order to reproduce this issue, we have implemented a `sb netrx` hook in =
`cmd/sb.c` that allows injecting arbitrary raw Ethernet RX frames into the =
networking stack.

The existing sandbox net driver only auto-generates limited packets (e.g. A=
RP/ping) and cannot deliver a crafted IPv6 frame with a bogus `payload_len`=
.=20

The `sb netrx` hook is a minimal injection path that calls `net_process_rec=
eived_packet()` directly on a buffer loaded into RAM, which is required to =
hit `net_ip6_handler()`.




```

diff --git a/cmd/sb.c b/cmd/sb.c

index 79f3fb0aacd..8e7604a13c4 100644

--- a/cmd/sb.c

+++ b/cmd/sb.c

@@ -6,6 +6,10 @@



#include <command.h>

#include <dm.h>

+#include <malloc.h>

+#include <mapmem.h>

+#include <net.h>

+#include <string.h>

#include <spl.h>

#include <asm/cpu.h>

#include <asm/global_data.h>

@@ -47,12 +51,52 @@ static int do_sb_state(struct cmd_tbl *cmdtp, int flag,=
 int argc,

return 0;

}



+static int do_sb_netrx(struct cmd_tbl *cmdtp, int flag, int argc,

+=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *const argv[])

+{

+=09ulong addr;

+=09unsigned int len;

+=09uchar *buf;

+=09uchar stack_buf[256];

+=09bool heap =3D false;

+=09void *src;

+

+=09if (argc !=3D 3)

+=09=09return CMD_RET_USAGE;

+

+=09addr =3D hextoul(argv[1], NULL);

+=09len =3D dectoul(argv[2], NULL);

+

+=09if (len > sizeof(stack_buf)) {

+=09=09buf =3D malloc(len);

+=09=09if (!buf)

+=09=09=09return CMD_RET_FAILURE;

+=09=09heap =3D true;

+=09} else {

+=09=09buf =3D stack_buf;

+=09}

+=09src =3D map_sysmem(addr, len);

+=09if (!src) {

+=09=09free(buf);

+=09=09return CMD_RET_FAILURE;

+=09}

+=09memcpy(buf, src, len);

+=09unmap_sysmem(src);

+=09net_process_received_packet(buf, len);

+=09if (heap)

+=09=09free(buf);

+

+=09return 0;

+}

+

U_BOOT_LONGHELP(sb,

"handoff=C2=A0=C2=A0=C2=A0=C2=A0 - Show handoff data received from SPL\n"

"sb map=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Show mapped memor=
y\n"

-=09"sb state=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Show sandbox state");

+=09"sb state=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Show sandbox state\n"

+=09"sb netrx <addr> <len> - inject a raw RX packet into net stack");



U_BOOT_CMD_WITH_SUBCMDS(sb, "Sandbox status commands", sb_help_text,

U_BOOT_SUBCMD_MKENT(handoff, 1, 1, do_sb_handoff),

U_BOOT_SUBCMD_MKENT(map, 1, 1, do_sb_map),

-=09U_BOOT_SUBCMD_MKENT(state, 1, 1, do_sb_state));

+=09U_BOOT_SUBCMD_MKENT(state, 1, 1, do_sb_state),

+=09U_BOOT_SUBCMD_MKENT(netrx, 3, 1, do_sb_netrx));

```




Proposed Patch:

The patch proposed by our system verifies that the payload length is within=
 bounds of the packet data before computing the checksum thus avoiding the =
Out-of-Bounds access.



```

diff --git a/net/net6.c b/net/net6.c

index 4cff98df15c..8453c1ca754 100644

--- a/net/net6.c

+++ b/net/net6.c

@@ -397,6 +397,9 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6=
_hdr *ip6, int len)

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 icmp =3D (struct icmp6hdr *)(((uchar *)ip6) + IP6_HDR_SIZE)=
;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 csum =3D icmp->icmp6_cksum;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 hlen =3D ntohs(ip6->payload_len);

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Validate payload length doesn't exceed available data */

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (hlen > len - IP6_HDR_SIZE)

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hlen =3D len -=
 IP6_HDR_SIZE;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 icmp->icmp6_cksum =3D 0;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* checksum */

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 csum_p =3D csum_partial((u8 *)icmp, hlen, 0);

@@ -424,6 +427,9 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6=
_hdr *ip6, int len)

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 udp =3D (struct udp_hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 csum =3D udp->udp_xsum;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 hlen =3D ntohs(ip6->payload_len);

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* Validate payload length doesn't exceed available data */

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (hlen > len - IP6_HDR_SIZE)

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hlen =3D len -=
 IP6_HDR_SIZE;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 udp->udp_xsum =3D 0;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* checksum */

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 csum_p =3D csum_partial((u8 *)udp, hlen, 0);



```


Crash backtrace:

```

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=3D=3D39394=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on address =
0xffffd7aea450 at pc 0xaaaacf7407fc bp 0xffffd7aea100 sp 0xffffd7aea0f0

READ of size 4 at 0xffffd7aea450 thread T0

=C2=A0=C2=A0=C2=A0 #0 0xaaaacf7407f8 in csum_do_csum net/net6.c:215

=C2=A0=C2=A0=C2=A0 #1 0xaaaacf7407f8 in csum_partial.constprop.0 net/net6.c=
:245

=C2=A0=C2=A0=C2=A0 #2 0xaaaacf5d0510 in net_ip6_handler net/net6.c:429

=C2=A0=C2=A0=C2=A0 #3 0xaaaacf5d0510 in net_process_received_packet net/net=
.c:1282

=C2=A0=C2=A0=C2=A0 #4 0xaaaacf345788 in do_sb_netrx cmd/sb.c:85

=C2=A0=C2=A0=C2=A0 #5 0xaaaacf3847a8 in cmd_call common/command.c:582

=C2=A0=C2=A0=C2=A0 #6 0xaaaacf3847a8 in cmd_process common/command.c:637

=C2=A0=C2=A0=C2=A0 #7 0xaaaacf37b5d4 in run_pipe_real common/cli_hush.c:167=
4

=C2=A0=C2=A0=C2=A0 #8 0xaaaacf37b5d4 in run_list_real common/cli_hush.c:187=
0

=C2=A0=C2=A0=C2=A0 #9 0xaaaacf37c2e0 in run_list common/cli_hush.c:2019

=C2=A0=C2=A0=C2=A0 #10 0xaaaacf37c2e0 in parse_stream_outer common/cli_hush=
.c:3209

=C2=A0=C2=A0=C2=A0 #11 0xaaaacf37c868 in parse_string_outer common/cli_hush=
.c:3275

=C2=A0=C2=A0=C2=A0 #12 0xaaaacf754940 in run_command_list.constprop.0 commo=
n/cli.c:149

=C2=A0=C2=A0=C2=A0 #13 0xaaaacf2bc980 in sandbox_main_loop_init arch/sandbo=
x/cpu/start.c:145

=C2=A0=C2=A0=C2=A0 #14 0xaaaacf2bc980 in run_main_loop common/board_r.c:583

=C2=A0=C2=A0=C2=A0 #15 0xaaaacf2bc980 in initcall_run_r common/board_r.c:78=
3

=C2=A0=C2=A0=C2=A0 #16 0xaaaacf2bc980 in board_init_r common/board_r.c:813

=C2=A0=C2=A0=C2=A0 #17 0xaaaacf2bc980 in sandbox_main arch/sandbox/cpu/star=
t.c:584

=C2=A0=C2=A0=C2=A0 #18 0xffffba7d73fc=C2=A0 (/lib/aarch64-linux-gnu/libc.so=
.6+0x273fc)

=C2=A0=C2=A0=C2=A0 #19 0xffffba7d74d4 in __libc_start_main (/lib/aarch64-li=
nux-gnu/libc.so.6+0x274d4)

=C2=A0=C2=A0=C2=A0 #20 0xaaaacf2ac9ec in _start (/src/simulation_environmen=
ts/xxx_uboot_issue_1/sources/xxx_uboot_issue_1/u-boot+0x27c9ec)



Address 0xffffd7aea450 is located in stack of thread T0 at offset 288 in fr=
ame

=C2=A0=C2=A0=C2=A0 #0 0xaaaacf345634 in do_sb_netrx cmd/sb.c:56



=C2=A0 This frame has 1 object(s):

=C2=A0=C2=A0=C2=A0 [32, 288) 'stack_buf' (line 60) <=3D=3D Memory access at=
 offset 288 overflows this variable

HINT: this may be a false positive if your program uses some custom stack u=
nwind mechanism, swapcontext or vfork

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (longjmp and C++ exceptions *are* supported)

SUMMARY: AddressSanitizer: stack-buffer-overflow net/net6.c:215 in csum_do_=
csum

Shadow bytes around the buggy address:

=C2=A0 0x200ffaf5d430: f1 f1 04 f2 04 f2 04 f2 04 f2 04 f2 04 f2 04 f2

=C2=A0 0x200ffaf5d440: 04 f2 04 f2 04 f2 00 00 f2 f2 00 00 04 f2 f2 f2

=C2=A0 0x200ffaf5d450: f2 f2 06 f3 f3 f3 00 00 00 00 00 00 00 00 00 00

=C2=A0 0x200ffaf5d460: 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 00

=C2=A0 0x200ffaf5d470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

=3D>0x200ffaf5d480: 00 00 00 00 00 00 00 00 00 00[f3]f3 f3 f3 f3 f3

=C2=A0 0x200ffaf5d490: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00

=C2=A0 0x200ffaf5d4a0: 00 00 00 00 f1 f1 f1 f1 04 f3 f3 f3 00 00 00 00

=C2=A0 0x200ffaf5d4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

=C2=A0 0x200ffaf5d4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

=C2=A0 0x200ffaf5d4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Shadow byte legend (one shadow byte represents 8 application bytes):

=C2=A0 Addressable:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 00

=C2=A0 Partially addressable: 01 02 03 04 05 06 07

=C2=A0 Heap left redzone:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fa

=C2=A0 Freed heap region:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd

=C2=A0 Stack left redzone:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f1

=C2=A0 Stack mid redzone:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f2

=C2=A0 Stack right redzone:=C2=A0=C2=A0=C2=A0=C2=A0 f3

=C2=A0 Stack after return:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f5

=C2=A0 Stack use after scope:=C2=A0=C2=A0 f8

=C2=A0 Global redzone:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 f9

=C2=A0 Global init order:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f6

=C2=A0 Poisoned by user:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f7

=C2=A0 Container overflow:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fc

=C2=A0 Array cookie:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ac

=C2=A0 Intra object redzone:=C2=A0=C2=A0=C2=A0 bb

=C2=A0 ASan internal:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 fe

=C2=A0 Left alloca redzone:=C2=A0=C2=A0=C2=A0=C2=A0 ca

=C2=A0 Right alloca redzone:=C2=A0=C2=A0=C2=A0 cb

=C2=A0 Shadow gap:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cc

=3D=3D39394=3D=3DABORTING

```



Reproduction Steps:

```

chmod +x build.sh poc.sh



# This clones the latest source code of u-boot from=C2=A0 https://source.de=
nx.de/u-boot/u-boot.git=20

# applies the patch for `sb netrx`
# and compiles the sandbox it with ASAN

./build.sh



# This crafts an IPv6 packet with an arbitrary payload length

# and invokes the `sb netrx` command with the crafted packet
./poc.sh

```


build.sh

```

#!/usr/bin/env bash

set -euo pipefail



ROOT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

UBOOT_DIR=3D"$ROOT_DIR/u-boot"



if [ ! -d "$UBOOT_DIR" ]; then

=C2=A0=C2=A0=C2=A0 git clone https://source.denx.de/u-boot/u-boot.git  "$UB=
OOT_DIR"

=C2=A0=C2=A0=C2=A0 patch -d "$UBOOT_DIR" -p1 < ../u-boot.patch

fi



cd "$UBOOT_DIR"



make sandbox_defconfig

./scripts/config --file .config -e ASAN

make olddefconfig

make -j"$(nproc)"



printf 'Built ASAN sandbox U-Boot at %s\n' "$UBOOT_DIR/u-boot"

```



poc.sh

```

#!/usr/bin/env bash

set -euo pipefail



ROOT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

UBOOT=3D"$ROOT_DIR/u-boot/u-boot"

POC_BIN=3D"$ROOT_DIR/ipv6_trunc.bin"



POC_BIN=3D"$POC_BIN" python3 - <<'PY'

import struct

import os

pkt =3D bytearray()

pkt +=3D b'\xff' * 6 + b'\x00' * 6 + struct.pack('!H', 0x86dd)

pkt +=3D bytes([0x60, 0, 0, 0])=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 # v6 header

pkt +=3D struct.pack('!H', 0xffff)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # pa=
yload_len (bogus)

pkt +=3D bytes([17, 64])=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # next header=3DUDP, hop limi=
t

pkt +=3D b'\x00' * 32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # src/dst

open(os.environ["POC_BIN"], "wb").write(pkt)

print(len(pkt))

PY



ASAN_OPTIONS=3Ddetect_leaks=3D0 \

"$UBOOT" -c "load hostfs - 0x100000 ipv6_trunc.bin && sb netrx 0x100000 54"

```



All the necessary files are also attached with this email.

Please investigate this issue.



Thank you for your time.
------=_Part_3503394_1198268125.1769796332215
Content-Type: text/plain; charset=us-ascii; name=backtrace.txt
Content-Transfer-Encoding: 7bit
X-ZM_AttachId: 139890891322150520
Content-Disposition: attachment; filename=backtrace.txt

54
Bloblist at 100 not found (err=-2)


U-Boot 2026.04-rc1 (Jan 29 2026 - 07:29:07 +0000)

DRAM:  256 MiB
Core:  29 devices, 15 uclasses, devicetree: board, universal payload active
NAND:  0 MiB
MMC:   
Loading Environment from nowhere... OK
Warning: device tree node '/config/environment' not found
In:    serial
Out:   serial,vidconsole
Err:   serial,vidconsole
Net:         eth_initialize() No ethernet found.

54 bytes read in 0 ms
=================================================================
==39394==ERROR: AddressSanitizer: stack-buffer-overflow on address 0xffffd7aea450 at pc 0xaaaacf7407fc bp 0xffffd7aea100 sp 0xffffd7aea0f0
READ of size 4 at 0xffffd7aea450 thread T0
    #0 0xaaaacf7407f8 in csum_do_csum net/net6.c:215
    #1 0xaaaacf7407f8 in csum_partial.constprop.0 net/net6.c:245
    #2 0xaaaacf5d0510 in net_ip6_handler net/net6.c:429
    #3 0xaaaacf5d0510 in net_process_received_packet net/net.c:1282
    #4 0xaaaacf345788 in do_sb_netrx cmd/sb.c:85
    #5 0xaaaacf3847a8 in cmd_call common/command.c:582
    #6 0xaaaacf3847a8 in cmd_process common/command.c:637
    #7 0xaaaacf37b5d4 in run_pipe_real common/cli_hush.c:1674
    #8 0xaaaacf37b5d4 in run_list_real common/cli_hush.c:1870
    #9 0xaaaacf37c2e0 in run_list common/cli_hush.c:2019
    #10 0xaaaacf37c2e0 in parse_stream_outer common/cli_hush.c:3209
    #11 0xaaaacf37c868 in parse_string_outer common/cli_hush.c:3275
    #12 0xaaaacf754940 in run_command_list.constprop.0 common/cli.c:149
    #13 0xaaaacf2bc980 in sandbox_main_loop_init arch/sandbox/cpu/start.c:145
    #14 0xaaaacf2bc980 in run_main_loop common/board_r.c:583
    #15 0xaaaacf2bc980 in initcall_run_r common/board_r.c:783
    #16 0xaaaacf2bc980 in board_init_r common/board_r.c:813
    #17 0xaaaacf2bc980 in sandbox_main arch/sandbox/cpu/start.c:584
    #18 0xffffba7d73fc  (/lib/aarch64-linux-gnu/libc.so.6+0x273fc)
    #19 0xffffba7d74d4 in __libc_start_main (/lib/aarch64-linux-gnu/libc.so.6+0x274d4)
    #20 0xaaaacf2ac9ec in _start (/src/simulation_environments/xxx_uboot_issue_1/sources/xxx_uboot_issue_1/u-boot+0x27c9ec)

Address 0xffffd7aea450 is located in stack of thread T0 at offset 288 in frame
    #0 0xaaaacf345634 in do_sb_netrx cmd/sb.c:56

  This frame has 1 object(s):
    [32, 288) 'stack_buf' (line 60) <== Memory access at offset 288 overflows this variable
HINT: this may be a false positive if your program uses some custom stack unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: stack-buffer-overflow net/net6.c:215 in csum_do_csum
Shadow bytes around the buggy address:
  0x200ffaf5d430: f1 f1 04 f2 04 f2 04 f2 04 f2 04 f2 04 f2 04 f2
  0x200ffaf5d440: 04 f2 04 f2 04 f2 00 00 f2 f2 00 00 04 f2 f2 f2
  0x200ffaf5d450: f2 f2 06 f3 f3 f3 00 00 00 00 00 00 00 00 00 00
  0x200ffaf5d460: 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 00
  0x200ffaf5d470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x200ffaf5d480: 00 00 00 00 00 00 00 00 00 00[f3]f3 f3 f3 f3 f3
  0x200ffaf5d490: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200ffaf5d4a0: 00 00 00 00 f1 f1 f1 f1 04 f3 f3 f3 00 00 00 00
  0x200ffaf5d4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200ffaf5d4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x200ffaf5d4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==39394==ABORTING

------=_Part_3503394_1198268125.1769796332215
Content-Type: application/octet-stream; name=build.sh
Content-Transfer-Encoding: 7bit
X-ZM_AttachId: 139890891322210280
Content-Disposition: attachment; filename=build.sh

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UBOOT_DIR="$ROOT_DIR/u-boot"

if [ ! -d "$UBOOT_DIR" ]; then
    git clone https://source.denx.de/u-boot/u-boot.git "$UBOOT_DIR"
    patch -d "$UBOOT_DIR" -p1 < ../u-boot.patch
fi

cd "$UBOOT_DIR"

make sandbox_defconfig
./scripts/config --file .config -e ASAN
make olddefconfig
make -j"$(nproc)"

printf 'Built ASAN sandbox U-Boot at %s\n' "$UBOOT_DIR/u-boot"

------=_Part_3503394_1198268125.1769796332215
Content-Type: application/octet-stream; name=poc.sh
Content-Transfer-Encoding: 7bit
X-ZM_AttachId: 139890891322220280
Content-Disposition: attachment; filename=poc.sh

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UBOOT="$ROOT_DIR/u-boot/u-boot"
POC_BIN="$ROOT_DIR/ipv6_trunc.bin"

POC_BIN="$POC_BIN" python3 - <<'PY'
import struct
import os
pkt = bytearray()
pkt += b'\xff' * 6 + b'\x00' * 6 + struct.pack('!H', 0x86dd)
pkt += bytes([0x60, 0, 0, 0])          # v6 header
pkt += struct.pack('!H', 0xffff)       # payload_len (bogus)
pkt += bytes([17, 64])                 # next header=UDP, hop limit
pkt += b'\x00' * 32                    # src/dst
open(os.environ["POC_BIN"], "wb").write(pkt)
print(len(pkt))
PY

ASAN_OPTIONS=detect_leaks=0 \
"$UBOOT" -c "load hostfs - 0x100000 ipv6_trunc.bin && sb netrx 0x100000 54"

------=_Part_3503394_1198268125.1769796332215
Content-Type: application/octet-stream; name=proposed_patch.diff
Content-Transfer-Encoding: 7bit
X-ZM_AttachId: 139890891322230400
Content-Disposition: attachment; filename=proposed_patch.diff

diff --git a/net/net6.c b/net/net6.c
index 4cff98df15c..8453c1ca754 100644
--- a/net/net6.c
+++ b/net/net6.c
@@ -397,6 +397,9 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
                icmp = (struct icmp6hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
                csum = icmp->icmp6_cksum;
                hlen = ntohs(ip6->payload_len);
+               /* Validate payload length doesn't exceed available data */
+               if (hlen > len - IP6_HDR_SIZE)
+                       hlen = len - IP6_HDR_SIZE;
                icmp->icmp6_cksum = 0;
                /* checksum */
                csum_p = csum_partial((u8 *)icmp, hlen, 0);
@@ -424,6 +427,9 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
                udp = (struct udp_hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
                csum = udp->udp_xsum;
                hlen = ntohs(ip6->payload_len);
+               /* Validate payload length doesn't exceed available data */
+               if (hlen > len - IP6_HDR_SIZE)
+                       hlen = len - IP6_HDR_SIZE;
                udp->udp_xsum = 0;
                /* checksum */
                csum_p = csum_partial((u8 *)udp, hlen, 0);


------=_Part_3503394_1198268125.1769796332215
Content-Type: application/octet-stream; name=u-boot.patch
Content-Transfer-Encoding: 7bit
X-ZM_AttachId: 139890891322240300
Content-Disposition: attachment; filename=u-boot.patch

diff --git a/cmd/sb.c b/cmd/sb.c
index 79f3fb0aacd..8e7604a13c4 100644
--- a/cmd/sb.c
+++ b/cmd/sb.c
@@ -6,6 +6,10 @@
 
 #include <command.h>
 #include <dm.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <net.h>
+#include <string.h>
 #include <spl.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
@@ -47,12 +51,52 @@ static int do_sb_state(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
+static int do_sb_netrx(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	ulong addr;
+	unsigned int len;
+	uchar *buf;
+	uchar stack_buf[256];
+	bool heap = false;
+	void *src;
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	addr = hextoul(argv[1], NULL);
+	len = dectoul(argv[2], NULL);
+
+	if (len > sizeof(stack_buf)) {
+		buf = malloc(len);
+		if (!buf)
+			return CMD_RET_FAILURE;
+		heap = true;
+	} else {
+		buf = stack_buf;
+	}
+	src = map_sysmem(addr, len);
+	if (!src) {
+		free(buf);
+		return CMD_RET_FAILURE;
+	}
+	memcpy(buf, src, len);
+	unmap_sysmem(src);
+	net_process_received_packet(buf, len);
+	if (heap)
+		free(buf);
+
+	return 0;
+}
+
 U_BOOT_LONGHELP(sb,
 	"handoff     - Show handoff data received from SPL\n"
 	"sb map         - Show mapped memory\n"
-	"sb state       - Show sandbox state");
+	"sb state       - Show sandbox state\n"
+	"sb netrx <addr> <len> - inject a raw RX packet into net stack");
 
 U_BOOT_CMD_WITH_SUBCMDS(sb, "Sandbox status commands", sb_help_text,
 	U_BOOT_SUBCMD_MKENT(handoff, 1, 1, do_sb_handoff),
 	U_BOOT_SUBCMD_MKENT(map, 1, 1, do_sb_map),
-	U_BOOT_SUBCMD_MKENT(state, 1, 1, do_sb_state));
+	U_BOOT_SUBCMD_MKENT(state, 1, 1, do_sb_state),
+	U_BOOT_SUBCMD_MKENT(netrx, 3, 1, do_sb_netrx));

------=_Part_3503394_1198268125.1769796332215--

